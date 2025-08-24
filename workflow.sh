#!/bin/bash

# Daily Development Workflow Helper Script
# Usage: ./workflow.sh [command]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper function for colored output
log() {
    echo -e "${GREEN}[$(date +'%H:%M:%S')]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[$(date +'%H:%M:%S')] WARNING:${NC} $1"
}

error() {
    echo -e "${RED}[$(date +'%H:%M:%S')] ERROR:${NC} $1"
}

# Function to display usage
show_help() {
    echo "Daily Development Workflow Helper"
    echo
    echo "Usage: $0 [command]"
    echo
    echo "Commands:"
    echo "  morning     - Start morning development session"
    echo "  feature     - Create new feature branch"
    echo "  commit      - Smart commit with conventional commits"
    echo "  cleanup     - Clean up development environment"
    echo "  update      - Update development tools"
    echo "  status      - Show development environment status"
    echo "  tmux        - Start/manage tmux sessions"
    echo "  project     - Quick project setup"
    echo
    echo "Examples:"
    echo "  $0 morning"
    echo "  $0 feature user-authentication"
    echo "  $0 commit 'feat: add user login functionality'"
    echo "  $0 cleanup"
}

# Morning routine
morning() {
    log "Starting morning development routine..."
    
    # Check if we're in a git repository
    if git rev-parse --git-dir > /dev/null 2>&1; then
        log "Checking Git status..."
        git status
        
        echo
        read -p "Pull latest changes? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            log "Pulling latest changes..."
            git pull origin $(git branch --show-current)
        fi
    else
        warn "Not in a Git repository"
    fi
    
    # Start tmux session if not already in one
    if [ -z "$TMUX" ]; then
        log "Starting tmux session..."
        tmux new-session -d -s "dev-$(date +%Y%m%d)" || tmux attach-session -t "dev-$(date +%Y%m%d)"
    else
        log "Already in tmux session: $(tmux display-message -p '#S')"
    fi
    
    # Check development environment
    log "Checking development environment..."
    if command -v node >/dev/null 2>&1; then
        echo "Node.js: $(node --version)"
    fi
    if command -v python3 >/dev/null 2>&1; then
        echo "Python: $(python3 --version)"
    fi
    if command -v go >/dev/null 2>&1; then
        echo "Go: $(go version | cut -d' ' -f3)"
    fi
    
    log "Morning routine complete! Ready to code"
}

# Create feature branch
feature() {
    if [ -z "$1" ]; then
        error "Please provide a feature name"
        echo "Usage: $0 feature <feature-name>"
        exit 1
    fi
    
    local feature_name="feature/$1"
    
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        error "Not in a Git repository"
        exit 1
    fi
    
    log "Creating feature branch: $feature_name"
    
    # Ensure we're on main/master
    local main_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    git checkout $main_branch
    git pull origin $main_branch
    
    # Create and switch to feature branch
    git checkout -b $feature_name
    
    log "Feature branch '$feature_name' created and checked out"
    log "Start coding! Don't forget to commit regularly"
}

# Smart commit with conventional commits
commit() {
    if [ -z "$1" ]; then
        error "Please provide a commit message"
        echo "Usage: $0 commit '<type>: <description>'"
        echo "Types: feat, fix, docs, style, refactor, test, chore"
        exit 1
    fi
    
    log "Staging all changes..."
    git add .
    
    log "Committing with message: $1"
    git commit -m "$1"
    
    echo
    read -p "Push to remote? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        local current_branch=$(git branch --show-current)
        log "Pushing to origin/$current_branch..."
        git push origin $current_branch
    fi
}

# Cleanup development environment
cleanup() {
    log "Cleaning up development environment..."
    
    # Node.js cleanup
    if [ -d "node_modules" ]; then
        log "Cleaning npm/yarn cache..."
        if command -v npm >/dev/null 2>&1; then
            npm cache clean --force
        fi
        if command -v yarn >/dev/null 2>&1; then
            yarn cache clean
        fi
    fi
    
    # Python cleanup
    if command -v python3 >/dev/null 2>&1; then
        log "Cleaning Python cache..."
        find . -type d -name "__pycache__" -delete 2>/dev/null || true
        find . -name "*.pyc" -delete 2>/dev/null || true
    fi
    
    # Go cleanup
    if command -v go >/dev/null 2>&1; then
        log "Cleaning Go cache..."
        go clean -cache
    fi
    
    # Docker cleanup
    if command -v docker >/dev/null 2>&1; then
        log "Cleaning Docker resources..."
        docker system prune -f
    fi
    
    # Git cleanup
    if git rev-parse --git-dir > /dev/null 2>&1; then
        log "Cleaning merged Git branches..."
        git branch --merged | grep -v -E "(main|master|\*)" | xargs -n 1 git branch -d 2>/dev/null || true
    fi
    
    log "Cleanup complete!"
}

# Update development tools
update() {
    log "Updating development tools..."
    
    # Update Node.js via NVM
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        log "Updating Node.js via NVM..."
        source "$NVM_DIR/nvm.sh"
        nvm install node --reinstall-packages-from=node
        nvm alias default node
    fi
    
    # Update Python packages
    if command -v pipx >/dev/null 2>&1; then
        log "Updating Python packages via pipx..."
        python3 -m pipx upgrade-all
    fi
    
    # Update Neovim plugins
    if command -v nvim >/dev/null 2>&1; then
        log "Updating Neovim plugins..."
        nvim --headless "+Lazy! sync" +qa
    fi
    
    log "Update complete! Please restart your terminal for changes to take effect."
}

# Show development environment status
status() {
    log "Development Environment Status"
    echo
    
    # System info
    echo "System:"
    echo "   OS: $(lsb_release -d | cut -f2)"
    echo "   Shell: $SHELL"
    
    # Development tools
    echo
    echo "Tools:"
    if command -v node >/dev/null 2>&1; then
        echo "   Node.js: $(node --version)"
        echo "   npm: $(npm --version)"
    else
        echo "   Node.js: not installed"
    fi
    
    if command -v python3 >/dev/null 2>&1; then
        echo "   Python: $(python3 --version)"
    else
        echo "   Python: not installed"
    fi
    
    if command -v go >/dev/null 2>&1; then
        echo "   Go: $(go version | cut -d' ' -f3)"
    else
        echo "   Go: not installed"
    fi
    
    if command -v nvim >/dev/null 2>&1; then
        echo "   Neovim: $(nvim --version | head -1)"
    else
        echo "   Neovim: not installed"
    fi
    
    if command -v tmux >/dev/null 2>&1; then
        echo "   Tmux: $(tmux -V)"
    else
        echo "   Tmux: not installed"
    fi
    
    # Git status
    echo
    echo "Git:"
    if git rev-parse --git-dir > /dev/null 2>&1; then
        echo "   Repository: $(basename $(git rev-parse --show-toplevel))"
        echo "   Branch: $(git branch --show-current)"
        echo "   Status: $(git status --porcelain | wc -l) changed files"
    else
        echo "   Not in a Git repository"
    fi
    
    # Tmux sessions
    echo
    echo "Tmux Sessions:"
    if command -v tmux >/dev/null 2>&1; then
        tmux list-sessions 2>/dev/null | sed 's/^/   /' || echo "   No active sessions"
    fi
}

# Tmux session management
tmux_session() {
    if ! command -v tmux >/dev/null 2>&1; then
        error "Tmux is not installed"
        exit 1
    fi
    
    echo "Tmux Session Manager"
    echo
    echo "1. Create new session"
    echo "2. List sessions"
    echo "3. Attach to session"
    echo "4. Kill session"
    echo
    read -p "Choose an option (1-4): " choice
    
    case $choice in
        1)
            read -p "Session name: " session_name
            tmux new-session -d -s "$session_name"
            log "Session '$session_name' created"
            ;;
        2)
            tmux list-sessions
            ;;
        3)
            tmux list-sessions
            read -p "Session name to attach: " session_name
            tmux attach-session -t "$session_name"
            ;;
        4)
            tmux list-sessions
            read -p "Session name to kill: " session_name
            tmux kill-session -t "$session_name"
            log "Session '$session_name' killed"
            ;;
        *)
            error "Invalid option"
            ;;
    esac
}

# Quick project setup
project() {
    echo "Quick Project Setup"
    echo
    echo "1. React/Next.js"
    echo "2. Angular"
    echo "3. Python/Django"
    echo "4. Go"
    echo "5. Node.js/Express"
    echo
    read -p "Choose project type (1-5): " choice
    read -p "Project name: " project_name
    
    case $choice in
        1)
            log "Setting up React/Next.js project..."
            npx create-next-app@latest "$project_name"
            cd "$project_name"
            ;;
        2)
            log "Setting up Angular project..."
            npx @angular/cli@latest new "$project_name"
            cd "$project_name"
            ;;
        3)
            log "Setting up Python/Django project..."
            mkdir "$project_name"
            cd "$project_name"
            python3 -m venv venv
            source venv/bin/activate
            pip install django
            django-admin startproject "$project_name" .
            ;;
        4)
            log "Setting up Go project..."
            mkdir "$project_name"
            cd "$project_name"
            go mod init "$project_name"
            echo 'package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}' > main.go
            ;;
        5)
            log "Setting up Node.js/Express project..."
            mkdir "$project_name"
            cd "$project_name"
            npm init -y
            npm install express
            echo 'const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
    res.json({ message: "Hello World!" });
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});' > index.js
            ;;
        *)
            error "Invalid option"
            exit 1
            ;;
    esac
    
    log "Project '$project_name' created successfully!"
    log "Run 'git init' to initialize Git repository"
}

# Main script logic
case "${1:-}" in
    morning)
        morning
        ;;
    feature)
        feature "$2"
        ;;
    commit)
        commit "$2"
        ;;
    cleanup)
        cleanup
        ;;
    update)
        update
        ;;
    status)
        status
        ;;
    tmux)
        tmux_session
        ;;
    project)
        project
        ;;
    *)
        show_help
        ;;
esac
