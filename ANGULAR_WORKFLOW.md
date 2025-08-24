# Angular Developer Daily Workflow

## Morning Routine for Angular Development

### 1. Environment Setup
```bash
# Start your development session
morning                  # or: workflow morning

# Navigate to your Angular project
cd ~/projects/my-angular-app

# Check git status and pull latest changes
git status
git pull origin main

# Check Angular CLI and dependencies
ng version
npm list --depth=0      # Check package versions
```

### 2. Development Environment Start
```bash
# Install/update dependencies (if package.json changed)
npm install

# Start the development server
ngserve                 # alias for: ng serve
# or with specific options:
ng serve --open --port 4200

# In a new terminal/tmux pane, start additional tools:
# Ctrl+A + | (split tmux vertically)

# Run tests in watch mode
npm run test            # or: ng test

# Run linting in watch mode (if configured)
npm run lint:watch      # or: ng lint --watch
```

## Core Angular Development Loop

### 3. Feature Development Workflow

#### Starting a New Feature
```bash
# Create feature branch
newfeature user-dashboard    # or: workflow feature user-dashboard

# Generate Angular components/services/modules
ng generate component features/user-dashboard
ng generate service services/user
ng generate module features/user-dashboard --routing

# Generate with specific options
ng g c shared/components/loading-spinner --skip-tests
ng g s core/services/auth --skip-tests=false
```

#### Development with AI Assistance (Neovim)
```bash
# Open project in Neovim
nvim .

# Key bindings for Angular development:
# <leader>ff   - Find files (search for components, services)
# <leader>sg   - Search in files (find text across project)
# <leader>gd   - Go to definition (navigate to imports)
# <leader>ca   - Code actions (auto-import, fix imports)
# <leader>rn   - Rename symbol (rename component, method)

# Copilot assistance for Angular:
# <Tab>        - Accept AI suggestions
# <leader>cp   - Copilot panel for multiple suggestions
# <leader>cs   - Copilot setup (if needed)
```

#### Angular-Specific Development Tasks
```bash
# Build for different environments
npm run build                    # Production build
npm run build:dev               # Development build
ng build --configuration=staging

# Run different types of tests
npm run test                    # Unit tests (Karma + Jasmine)
npm run test:coverage          # With coverage report
npm run e2e                    # End-to-end tests (if configured)

# Code quality checks
npm run lint                   # ESLint
npm run lint:fix               # Auto-fix linting issues
npm run format                 # Prettier formatting (if configured)

# Angular-specific commands
ng analyze                     # Bundle analyzer
ng update                      # Update Angular packages
ng add @angular/material       # Add Angular Material
```

### 4. Testing & Debugging Angular Apps

#### Unit Testing
```bash
# Run tests for specific component
npm test -- --include="**/user.component.spec.ts"

# Run tests with coverage
npm run test:coverage

# Debug tests in browser
npm test -- --browsers=Chrome --watch=true
```

#### E2E Testing
```bash
# If using Cypress
npm run e2e
npm run e2e:open

# If using Protractor (legacy)
npm run e2e

# If using Playwright
npx playwright test
```

#### Debugging in Development
```bash
# Debug in VS Code/Neovim with browser devtools
# 1. Set breakpoints in TypeScript files
# 2. Open browser devtools (F12)
# 3. Use Angular DevTools extension
# 4. Check Console, Network, and Elements tabs

# Debug Angular-specific issues:
# - Component lifecycle issues
# - Change detection problems
# - Dependency injection errors
# - Routing issues
```

### 5. Angular Project Management

#### Dependency Management
```bash
# Update Angular and CLI
ng update @angular/core @angular/cli

# Update specific packages
ng update @angular/material

# Add new dependencies
npm install lodash
npm install --save-dev @types/lodash

# Remove unused dependencies
npm uninstall package-name
npm prune
```

#### Environment Configuration
```bash
# Different environment builds
ng build --configuration=production
ng build --configuration=staging
ng build --configuration=development

# Serve with specific environment
ng serve --configuration=staging
```

## Angular-Specific Git Workflow

### 6. Committing Angular Changes
```bash
# Stage changes
git add .

# Commit with Angular conventional commits
smartcommit "feat(dashboard): add user statistics component"
smartcommit "fix(auth): resolve login form validation issue"
smartcommit "refactor(shared): extract common table component"
smartcommit "test(user): add unit tests for user service"
smartcommit "docs(readme): update setup instructions"

# Angular-specific commit types:
# feat: new features
# fix: bug fixes
# refactor: code refactoring
# test: adding tests
# docs: documentation
# style: formatting, missing semicolons, etc.
# perf: performance improvements
# build: build system changes
# ci: CI configuration changes
```

## Evening Wrap-up for Angular Projects

### 7. End of Day Routine
```bash
# Run final tests and builds
npm run test:ci                 # Run tests without watch
npm run build                   # Ensure production build works
npm run lint                    # Final lint check

# Clean up development environment
devcleanup                      # Clean caches and temporary files

# Commit end-of-day work
smartcommit "wip: end of day checkpoint - dashboard feature"

# Update git
git push origin feature/user-dashboard

# Create pull request (if ready)
gh pr create --title "feat: Add user dashboard" --body "Implements user statistics and analytics dashboard"
```

## Angular-Specific Pro Tips

### 8. Productivity Enhancements

#### Angular CLI Shortcuts
```bash
# Add to ~/.zshrc for additional Angular aliases:
alias ngg="ng generate"
alias ngc="ng generate component"
alias ngs="ng generate service"
alias ngm="ng generate module"
alias ngb="ng build"
alias ngt="ng test"
alias ngl="ng lint"

# Component generation with common options
alias ngcp="ng generate component --skip-tests=false --style=scss"
alias ngcs="ng generate component --skip-tests=true --inline-template=true"
```

#### Project Structure Best Practices
```bash
# Recommended Angular project structure workflow:
src/
├── app/
│   ├── core/              # Singleton services, guards
│   ├── shared/            # Shared components, pipes, directives
│   ├── features/          # Feature modules
│   │   ├── auth/
│   │   ├── dashboard/
│   │   └── user-profile/
│   └── layout/            # Layout components
```

#### Development Server Optimization
```bash
# For large projects, optimize development server:
ng serve --hmr                    # Hot module replacement
ng serve --source-map=false       # Faster builds
ng serve --vendor-chunk=false     # Smaller bundles

# Use custom webpack config (if needed)
ng build --custom-webpack-config=webpack.config.js
```

### 9. Angular DevOps Workflow

#### Build and Deployment
```bash
# Production build with optimizations
ng build --configuration=production --aot --build-optimizer

# Analyze bundle size
ng build --stats-json
npx webpack-bundle-analyzer dist/stats.json

# Deploy to different environments
npm run deploy:staging
npm run deploy:production
```

#### Continuous Integration
```bash
# CI/CD pipeline commands (add to package.json):
"scripts": {
  "ci:install": "npm ci",
  "ci:lint": "ng lint",
  "ci:test": "ng test --watch=false --browsers=ChromeHeadless",
  "ci:e2e": "ng e2e --protractor-config=e2e/ci-protractor.conf.js",
  "ci:build": "ng build --configuration=production"
}
```

## Weekly Maintenance for Angular Projects

### 10. Weekly Tasks
```bash
# Update dependencies
devupdate                       # Updates Node.js, npm, tools
ng update                       # Check for Angular updates
npm audit                       # Security audit
npm audit fix                   # Fix security issues

# Clean up and optimize
npm run clean                   # Clean dist folder
npm prune                       # Remove unused packages
git branch --merged | grep -v main | xargs git branch -d  # Clean branches

# Performance checks
ng build --stats-json           # Generate stats
npm run analyze                 # Bundle analysis
lighthouse http://localhost:4200  # Performance audit
```

This Angular-specific workflow integrates perfectly with your existing dotfiles setup and provides a structured approach to Angular development from morning setup to evening wrap-up!
