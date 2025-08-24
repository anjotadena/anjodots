# anjodots

A comprehensive dotfiles repository and setup script for WSL Ubuntu 24.04 that creates a professional development environment for Angular, React, Python, and Go developers.

## Features

### Development Environment
- **Node.js via NVM**: Latest LTS with yarn, pnpm, Angular CLI, Create React App
- **Python 3**: pipx, virtualenv, virtualenvwrapper, black, flake8 (PEP 668 compliant)
- **Go**: Latest stable (1.23+)
- **Essential Tools**: git, curl, wget, build-essential, tmux, fzf, ripgrep, fd-find

### Terminal & Shell
- **Zsh + Oh My Zsh**: Professional shell with powerlevel10k theme
- **Plugins**: git, autosuggestions, syntax-highlighting, fzf
- **Development shortcuts**: Quick aliases for npm/yarn, Python, Go, Docker
- **Git configuration**: Optional setup for user name, email, and defaults

### Tmux Configuration
- **Prefix**: Ctrl+A (easier than Ctrl+B)
- **Vim-style navigation**: h/j/k/l for pane switching
- **Easy splits**: | (vertical) and - (horizontal)
- **Mouse support**: Click to switch panes and resize
- **Plugin Manager**: TPM with sensible, resurrect, continuum plugins
- **Professional theme**: Dark theme with git branch display

### Neovim + LazyVim
- **LSP Integration**: tsserver, pyright, gopls with auto-install via Mason
- **Formatters**: Prettier (JS/TS), Black (Python), gofumpt (Go)
- **Linters**: ESLint, flake8
- **Debugging**: DAP support for all languages
- **AI Assistance**: GitHub Copilot integration with smart keybindings
- **Custom keymaps**: Language-specific shortcuts for productivity

### Error Handling
- **Rollback support**: Automatic cleanup on installation failure
- **Backup system**: Existing configs backed up before installation
- **Progress indicators**: Clear feedback during setup process

## Installation

```bash
git clone https://github.com/your-username/anjodots.git
cd anjodots
chmod +x setup.sh
./setup.sh
```

After installation:
1. Restart your terminal or run `zsh`
2. Run `tmux` and press `Ctrl+A + I` to install Tmux plugins
3. Open `nvim` to automatically install plugins via LazyVim
4. Run `:Mason` in Neovim to verify LSP/formatter installations

**Note**: The setup script will optionally prompt you to configure git user information (name, email, and defaults) if not already set.

## Key Bindings

### Angular/React Development
- `<leader>rf` - Rename TypeScript/JavaScript file
- `<leader>oi` - Organize imports
- `<leader>ai` - Add missing imports
- `<leader>cf` - Format with Prettier

### Python Development
- `<leader>dt` - Debug test method
- `<leader>df` - Debug test class
- `<leader>pf` - Format with Black

### Go Development
- `<leader>gt` - Run Go tests
- `<leader>gr` - Run Go main
- `<leader>gb` - Build Go project

### Debugging (All Languages)
- `<leader>dd` - Toggle breakpoint
- `<leader>dc` - Continue debugging
- `<leader>do` - Step over
- `<leader>di` - Step into
- `<leader>du` - Step out

### GitHub Copilot
- `<Tab>` - Accept Copilot suggestion (in insert mode)
- `<Ctrl>]` - Open Copilot panel
- `<Ctrl>\` - Disable Copilot
- `<Ctrl>[` - Enable Copilot
- `<leader>cs` - Copilot setup/authentication
- `<leader>cp` - Copilot panel
- `<leader>ce` - Copilot enable
- `<leader>cd` - Copilot disable
- `<leader>cS` - Copilot status

**Setup Commands:**
- `:Copilot setup` - Initial authentication with GitHub
- `:CopilotInit` - Auto-setup helper (checks status and runs setup if needed)
- `:CopilotCheck` - Check authentication and status
- `:Copilot status` - Show current status and diagnostics

### Tmux
- `Ctrl+A` - Prefix key
- `Ctrl+A + |` - Split vertically
- `Ctrl+A + -` - Split horizontally
- `Ctrl+A + h/j/k/l` - Navigate panes
- `Ctrl+A + H/J/K/L` - Resize panes
- `Ctrl+A + r` - Reload config

### Development Shortcuts
- **Node.js**: `nrd` (npm run dev), `yrs` (yarn start), `ngserve` (ng serve)
- **Python**: `py` (python3), `serve` (http.server), `venv` (create venv)
- **Go**: `gorun` (go run .), `gotest` (go test ./...), `gomod` (go mod tidy)
- **Docker**: `dcup` (docker-compose up), `dcdown` (down), `dps` (docker ps)

## Project Structure

```
anjodots/
├── setup.sh              # Main installation script
├── .zshrc                # Zsh configuration
├── .tmux.conf            # Tmux configuration
├── .tmux.theme.conf      # Tmux theme
├── nvim/
│   ├── init.lua          # Neovim initialization
│   └── lua/plugins/
│       └── dev.lua       # Development plugins
└── README.md             # This file
```

## Mason Auto-Install Packages

The setup automatically installs these packages via Mason:

### Angular/React
- typescript-language-server
- eslint_d
- prettierd

### Python
- pyright
- black
- flake8

### Go
- gopls
- gofumpt
- delve

## Customization

### Adding New Plugins
Edit `nvim/lua/plugins/dev.lua` to add new Neovim plugins.

### Modifying Tmux Theme
Edit `.tmux.theme.conf` to customize colors and status bar.

### Adding Aliases
Add new aliases to `.zshrc` in the aliases section.

## Troubleshooting

### Permission Issues with npm
The setup uses NVM instead of system Node.js to avoid permission issues. If you encounter npm permission errors, ensure NVM is properly loaded:

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

### Python Environment Issues
The setup uses pipx to install Python tools in isolated environments (PEP 668 compliant). If you encounter Python package issues:

```bash
# Verify pipx installation
python3 -m pipx list

# Install additional tools via pipx
python3 -m pipx install package-name

# For project-specific dependencies, use virtual environments
python3 -m venv myproject
source myproject/bin/activate
pip install package-name
```

### Tmux Plugins Not Installing
After running the setup, ensure you install Tmux plugins manually:

```bash
tmux
# Press Ctrl+A + I
```

### Neovim Plugins Issues
If LazyVim plugins don't install automatically:

```bash
nvim
:Lazy sync
:Mason
```

### GitHub Copilot Issues
If Copilot commands are not found or authentication fails:

```bash
# In Neovim, run these commands:
:CopilotCheck                    # Check current status
:Copilot setup                   # Authenticate with GitHub (opens browser)
:CopilotInit                     # Auto-setup helper

# If still having issues, check plugin loading:
:Lazy                           # Open plugin manager
# Find copilot.vim and press 'I' to inspect

# Manual authentication:
:Copilot auth                   # Alternative authentication method
```

**Note**: You need a GitHub account with Copilot subscription to use this feature.

## License

MIT License - feel free to use and modify as needed.
