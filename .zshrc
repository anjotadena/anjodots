# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Export PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# NVM (load silently to avoid instant prompt issues)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" &>/dev/null
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" &>/dev/null

# Yarn global path (check if yarn exists first)
if command -v yarn &> /dev/null; then
  export PATH="$(yarn global bin 2>/dev/null):$PATH"
fi

# Python virtualenvwrapper (load silently and check dependencies)
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/projects
export VIRTUALENVWRAPPER_PYTHON=$(which python3 2>/dev/null)
if [ -f "$HOME/.local/bin/virtualenvwrapper.sh" ] && [ -n "$VIRTUALENVWRAPPER_PYTHON" ]; then
  source "$HOME/.local/bin/virtualenvwrapper.sh" &>/dev/null
fi

# Aliases
alias cls="clear"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias gco="git checkout"
alias gb="git branch"
alias gd="git diff"
alias ga="git add"

# Development shortcuts
# Node.js/React/Angular
alias nrd="npm run dev"
alias nrs="npm run start"
alias nrb="npm run build"
alias nrt="npm run test"
alias yrd="yarn dev"
alias yrs="yarn start"
alias yrb="yarn build"
alias yrt="yarn test"

# Angular CLI shortcuts
alias ngserve="ng serve"
alias ngbuild="ng build"
alias ngtest="ng test"
alias ngg="ng generate"
alias ngc="ng generate component"
alias ngs="ng generate service"
alias ngm="ng generate module"
alias ngl="ng lint"
alias ngcp="ng generate component --skip-tests=false --style=scss"
alias ngcs="ng generate component --skip-tests=true --inline-template=true"
alias ngu="ng update"
alias nga="ng add"
alias nganalyze="ng build --stats-json && npx webpack-bundle-analyzer dist/stats.json"

# Python
alias py="python3"
alias pip="python3 -m pip"
alias venv="python3 -m venv"
alias serve="python3 -m http.server"
alias pyrun="python3 -m"

# Go
alias gorun="go run ."
alias gobuild="go build ."
alias gotest="go test ./..."
alias gomod="go mod tidy"

# Docker (common commands)
alias dcup="docker-compose up"
alias dcdown="docker-compose down"
alias dcbuild="docker-compose build"
alias dps="docker ps"
alias dlogs="docker logs"

# Daily workflow shortcuts
alias morning="workflow morning"
alias devstatus="workflow status"
alias devcleanup="workflow cleanup"
alias devupdate="workflow update"
alias newfeature="workflow feature"
alias smartcommit="workflow commit"

# Angular workflow shortcuts
alias ngcheck="workflow ng-check"
alias ngdev="workflow ng-start"
alias ngdeploy="workflow ng-deploy"

# Quick tmux shortcuts
alias tnew="tmux new-session -s"
alias tlist="tmux list-sessions"
alias tattach="tmux attach-session -t"

# Angular workflow functions
ngstart() {
  echo "Starting Angular development environment..."
  echo "Opening development server..."
  ng serve --open &
  echo "Starting tests in watch mode..."
  npm run test &
  echo "Angular dev environment started!"
}

ngnew() {
  if [ -z "$1" ]; then
    echo "Usage: ngnew <project-name> [options]"
    echo "Example: ngnew my-app --routing --style=scss"
    return 1
  fi
  echo "Creating new Angular project: $1"
  ng new "$@" --package-manager=npm --skip-git=false
  cd "$1"
  echo "Project created! Running initial setup..."
  npm install
  echo "Opening project..."
  code . || nvim .
}

ngfeat() {
  if [ -z "$1" ]; then
    echo "Usage: ngfeat <feature-name>"
    echo "This will create a feature module with routing and a main component"
    return 1
  fi
  echo "Creating feature module: $1"
  ng generate module "features/$1" --routing
  ng generate component "features/$1"
  echo "Feature module '$1' created successfully!"
}

ngdeploy() {
  echo "Building for production..."
  ng build --configuration=production
  if [ $? -eq 0 ]; then
    echo "Production build successful!"
    echo "Build output is in: dist/"
  else
    echo "Build failed!"
    return 1
  fi
}

ngcheck() {
  echo "Running Angular project health check..."
  echo "1. Checking Angular CLI version..."
  ng version --skip-git
  echo ""
  echo "2. Running linting..."
  ng lint
  echo ""
  echo "3. Running tests..."
  ng test --watch=false --browsers=ChromeHeadless
  echo ""
  echo "4. Building for production..."
  ng build --configuration=production
  echo ""
  echo "Angular project health check complete!"
}

# FZF configuration
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
