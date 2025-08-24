#!/usr/bin/env bash
set -e

echo "Setting up WSL Ubuntu 24.04 for Angular/React/Python/Go Development..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Function to rollback changes
rollback() {
    echo "Rolling back changes..."
    if [ -d "$BACKUP_DIR" ]; then
        echo "Restoring backed up files..."
        cp -r "$BACKUP_DIR"/.* "$HOME/" 2>/dev/null || true
    fi
    if [ -d "$HOME/.nvm" ]; then
        echo "Removing NVM installation..."
        rm -rf "$HOME/.nvm"
    fi
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo "Removing Oh My Zsh installation..."
        rm -rf "$HOME/.oh-my-zsh"
    fi
    if [ -d "$HOME/.tmux/plugins" ]; then
        echo "Removing Tmux plugins..."
        rm -rf "$HOME/.tmux/plugins"
    fi
    echo "Rollback completed. You may need to manually remove some system packages."
    exit 1
}

# Function to backup existing configs
backup_existing() {
    echo "Creating backup of existing configurations..."
    mkdir -p "$BACKUP_DIR"
    for file in .zshrc .tmux.conf .tmux.theme.conf; do
        if [ -f "$HOME/$file" ]; then
            cp "$HOME/$file" "$BACKUP_DIR/"
        fi
    done
    if [ -d "$HOME/.config/nvim" ]; then
        cp -r "$HOME/.config/nvim" "$BACKUP_DIR/"
    fi
}

# --- Essentials ---
echo "Installing essential packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl wget zsh unzip build-essential tmux fzf ripgrep fd-find python3-pip python3-venv

# --- NVM (Node Version Manager) + Node.js ---
echo "Installing NVM..."
if curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  
  echo "Installing Node.js LTS via NVM..."
  if nvm install --lts && nvm use --lts; then
    echo "Installing global packages..."
    npm install -g yarn pnpm @angular/cli create-react-app
    echo "Node.js and global packages installed successfully via NVM"
  else
    echo "Failed to install Node.js via NVM"
    echo "Rolling back NVM installation..."
    rm -rf "$HOME/.nvm"
    echo "You can try installing Node.js manually or re-run this script"
    rollback
  fi
else
  echo "Failed to install NVM"
  echo "Please check your internet connection and try again"
  rollback
fi

# --- Python ---
echo "Installing Python packages..."
# Install essential Python packages
sudo apt install -y python3-venv python3-full python3-pip

# Install pipx (using break-system-packages as pipx manages isolated environments)
python3 -m pip install --user --break-system-packages pipx
python3 -m pipx ensurepath

# Install Python tools via pipx (isolated environments)
python3 -m pipx install black
python3 -m pipx install flake8
python3 -m pipx install virtualenv
python3 -m pipx install virtualenvwrapper

# Ensure pipx binaries are in PATH for current session
export PATH="$HOME/.local/bin:$PATH"

# --- Go ---
echo "Installing Go..."
GO_VERSION=1.23.0
wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
rm go${GO_VERSION}.linux-amd64.tar.gz

# --- Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  chsh -s $(which zsh)
fi

# Plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting || true
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k || true

# --- Neovim + LazyVim ---
echo "Installing Neovim..."
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
rm nvim-linux-x86_64.tar.gz

# Backup existing Neovim configs
backup_existing

# Remove existing nvim config if it exists to avoid conflicts
if [ -d "$HOME/.config/nvim" ]; then
  rm -rf "$HOME/.config/nvim"
fi

# Clone the official LazyVim starter
echo "Installing LazyVim starter..."
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Replace with our custom configs
cp -f $DOTFILES_DIR/nvim/lua/plugins/extras.lua ~/.config/nvim/lua/plugins/
cp -f $DOTFILES_DIR/nvim/lua/plugins/dev.lua ~/.config/nvim/lua/plugins/

echo "LazyVim starter installed with custom development plugins"

# --- Tmux ---
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# --- Apply Dotfiles (symlinks) ---
echo "Linking dotfiles from $DOTFILES_DIR"

ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/.tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/.tmux.theme.conf ~/.tmux.theme.conf

# --- Git Configuration (Optional) ---
echo ""
echo "=== Git Configuration ==="
current_name=$(git config --global user.name 2>/dev/null || echo "")
current_email=$(git config --global user.email 2>/dev/null || echo "")

if [ -n "$current_name" ] && [ -n "$current_email" ]; then
  echo "Current git configuration:"
  echo "  Name:  $current_name"
  echo "  Email: $current_email"
  echo ""
  read -p "Do you want to update your git configuration? (y/N): " update_git
else
  echo "No git user configuration found."
  read -p "Do you want to configure git user information? (y/N): " update_git
fi

if [[ $update_git =~ ^[Yy]$ ]]; then
  echo ""
  read -p "Enter your full name: " git_name
  read -p "Enter your email address: " git_email
  
  if [ -n "$git_name" ] && [ -n "$git_email" ]; then
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    
    # Optional: Set some useful git defaults
    echo ""
    read -p "Set recommended git defaults? (default branch: main, pull rebase) (y/N): " git_defaults
    if [[ $git_defaults =~ ^[Yy]$ ]]; then
      git config --global init.defaultBranch main
      git config --global pull.rebase true
      git config --global core.autocrlf input
      git config --global core.editor nvim
      echo "Git defaults configured!"
    fi
    
    echo ""
    echo "Git configuration updated:"
    echo "  Name:  $(git config --global user.name)"
    echo "  Email: $(git config --global user.email)"
  else
    echo "Git configuration skipped (empty values provided)."
  fi
else
  echo "Git configuration skipped."
fi

echo ""
echo "Setup complete! Restart terminal or run 'zsh'."
echo "Run 'tmux' and press Ctrl+A + I to install Tmux plugins."
echo "Open nvim to automatically install plugins via LazyVim."
