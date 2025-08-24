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

### Workflow Helper Commands
- **Daily routine**: `morning` (start dev session), `devstatus` (environment status)
- **Project management**: `newfeature <name>` (create feature branch), `smartcommit "<message>"` (commit & push)
- **Maintenance**: `devcleanup` (clean caches), `devupdate` (update tools)
- **Tmux**: `tnew <name>` (new session), `tlist` (list), `tattach <name>` (attach)

### Workflow Script Usage
```bash
# Available commands (installed as 'workflow' command):
workflow morning          # Start morning routine
workflow feature my-feat  # Create feature branch
workflow commit "feat: add login"  # Smart commit
workflow status          # Show environment status
workflow cleanup         # Clean development environment
workflow update          # Update development tools
workflow tmux           # Tmux session manager
workflow project        # Quick project setup
```

## Daily Workflow

### Quick Start
```bash
# Morning routine (all-in-one)
morning              # or: workflow morning

# Check environment
devstatus           # or: workflow status

# Start new feature
newfeature my-feature    # or: workflow feature my-feature

# Smart commit and push
smartcommit "feat: add awesome feature"  # or: workflow commit "..."

# End of day cleanup
devcleanup          # or: workflow cleanup
```

### Morning Setup
```bash
# 1. Start your development session
tmux new-session -s dev

# 2. Navigate to your project
cd ~/projects/your-project

# 3. Check git status and pull latest changes
git status
git pull origin main

# 4. Start your development environment
nrd          # For React/Next.js projects
# or
ngserve      # For Angular projects
# or
gorun        # For Go projects
# or
py manage.py runserver  # For Django projects
```

### Core Development Loop

#### Starting a New Feature
```bash
# Create and switch to feature branch
git checkout -b feature/awesome-feature

# Open project in Neovim with file explorer
nvim .

# Split terminal for development (in tmux)
# Ctrl+A + | (vertical split)
# Ctrl+A + - (horizontal split)
```

#### Coding with AI Assistance
```bash
# In Neovim:
# 1. Ensure Copilot is set up (first time only)
:Copilot setup

# 2. Start coding with AI suggestions
# - Type your code, AI suggestions appear automatically
# - Press <Tab> to accept suggestions
# - Use <leader>cp for Copilot panel with multiple suggestions

# 3. Quick development shortcuts
<leader>ff   # Find files (telescope)
<leader>sg   # Search in files (grep)
<leader>gd   # Go to definition
<leader>ca   # Code actions
<leader>rn   # Rename symbol
```

#### Testing & Debugging
```bash
# For different project types:

# Node.js/React/Angular:
npm test              # Run tests
npm run test:watch    # Watch mode
npm run lint          # Check linting
npm run build         # Production build

# Python:
pytest                # Run tests
pytest --cov          # With coverage
python -m flake8      # Linting
black .               # Format code

# Go:
gotest               # Run all tests (alias)
go test -v ./...     # Verbose testing
go mod tidy          # Clean dependencies
gofumpt -w .         # Format code

# In Neovim for debugging:
<leader>db   # Set breakpoint
<leader>dc   # Continue debugging
<leader>ds   # Step over
<leader>di   # Step into
```

#### Git Workflow
```bash
# Check what changed
git status
git diff

# Stage and commit changes
git add .
git commit -m "feat: add awesome feature"

# Push feature branch
git push origin feature/awesome-feature

# Create pull request (GitHub CLI if installed)
gh pr create --title "Add awesome feature" --body "Description of changes"
```

### Evening Wrap-up
```bash
# 1. Save current tmux session
tmux capture-pane -t dev -p > ~/dev-session-$(date +%Y%m%d).log

# 2. Commit any work in progress
git add .
git commit -m "wip: end of day checkpoint"
git push origin feature/awesome-feature

# 3. Clean up environment
docker system prune -f    # Clean Docker resources
npm cache clean --force   # Clean npm cache (if needed)

# 4. Detach from tmux (keeps session running)
# Ctrl+A + d

# 5. Next day: reattach to session
tmux attach-session -t dev
```

### Maintenance Tasks (Weekly)

#### System Updates
```bash
# Update packages
sudo apt update && sudo apt upgrade

# Update Node.js via NVM
nvm install node --reinstall-packages-from=node
nvm alias default node

# Update Python packages
python3 -m pipx upgrade-all

# Update Go
# Check https://golang.org/dl/ for latest version
# Download and install manually

# Update Neovim plugins
nvim +Lazy update +qa

# Update Tmux plugins
# Ctrl+A + I (in tmux)
```

#### Project Cleanup
```bash
# Clean node_modules and reinstall (for Node.js projects)
rm -rf node_modules package-lock.json
npm install

# Clean Python cache
find . -type d -name "__pycache__" -delete
find . -name "*.pyc" -delete

# Clean Go cache
go clean -cache
go clean -modcache

# Clean Git branches
git branch --merged | grep -v main | xargs git branch -d
```

### Project-Specific Quick Starts

#### Angular Project
```bash
cd ~/projects/my-angular-app
nvm use 18                    # Use specific Node version
npm install                   # Install dependencies
ngserve                      # Start dev server (alias)
# In new terminal/tmux pane:
npm run test                 # Run tests in watch mode
```

#### React/Next.js Project
```bash
cd ~/projects/my-react-app
nvm use latest               # Use latest Node
yarn install                # or npm install
yrs                         # Start dev server (yarn start alias)
# or
nrd                         # npm run dev alias
```

#### Python/Django Project
```bash
cd ~/projects/my-django-app
python3 -m venv venv        # Create virtual environment
source venv/bin/activate    # Activate environment
pip install -r requirements.txt
python manage.py migrate    # Run migrations
python manage.py runserver  # Start dev server
```

#### Go Project
```bash
cd ~/projects/my-go-app
gomod                       # Clean dependencies (go mod tidy alias)
gorun                       # Run application (go run . alias)
# In new terminal:
gotest                      # Run tests (go test ./... alias)
```

### Pro Tips

1. **Use tmux sessions for different projects**:
   ```bash
   tmux new-session -s frontend
   tmux new-session -s backend
   tmux new-session -s devops
   ```

2. **Leverage Neovim's workspace features**:
   - `:Telescope find_files` for quick file navigation
   - `:Telescope live_grep` for searching across files
   - `:Telescope git_files` for Git-tracked files only

3. **Use development shortcuts effectively**:
   - Create custom aliases in `.zshrc` for your specific projects
   - Use `npm run` scripts for consistent commands across projects

4. **Copilot best practices**:
   - Write descriptive comments to get better suggestions
   - Use the panel (`<leader>cp`) for multiple options
   - Don't forget to review AI suggestions before accepting

## Project Structure

```
anjodots/
├── setup.sh              # Main installation script
├── workflow.sh           # Daily workflow helper script
├── .zshrc                # Zsh configuration with development shortcuts
├── .tmux.conf            # Tmux configuration
├── .tmux.theme.conf      # Tmux theme
├── nvim/
│   ├── init.lua          # Neovim initialization
│   └── lua/
│       ├── config/
│       │   ├── lazy.lua        # LazyVim configuration
│       │   └── copilot-init.lua # Copilot helper commands
│       └── plugins/
│           └── dev.lua         # Development plugins
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
