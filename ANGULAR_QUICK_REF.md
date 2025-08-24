# Angular Developer Quick Reference

## Daily Commands (with your dotfiles setup)

### Morning Routine
```bash
morning                 # Start development session
cd ~/projects/my-angular-app
ngcheck                 # Health check your Angular project
ngdev                   # Start dev server with tests
```

### Development Flow
```bash
# Create feature branch
newfeature dashboard-stats

# Generate Angular components
ngc dashboard-stats              # ng generate component dashboard-stats
ngs user-service                 # ng generate service user-service
ngm shared-module --routing      # ng generate module shared-module --routing

# Development with shortcuts
ngserve                          # ng serve --open
ngtest                          # ng test (in separate terminal)
ngl                             # ng lint

# Smart commits (conventional commits)
smartcommit "feat(dashboard): add user statistics component"
smartcommit "fix(auth): resolve token refresh issue"
smartcommit "refactor(shared): extract common table component"
```

### AI-Powered Development (Neovim + Copilot)
```bash
nvim .                          # Open project in Neovim

# Key bindings in Neovim:
# <Tab>        - Accept Copilot suggestion
# <leader>cp   - Copilot panel for multiple suggestions
# <leader>cs   - Check Copilot status
# <leader>ff   - Find files (Telescope)
# <leader>sg   - Search in files
# <leader>ca   - Code actions (auto-import, fix)
# <leader>rn   - Rename symbol
```

### Project Quality & Deployment
```bash
ngcheck                         # Full project health check
ngdeploy                       # Build and prepare for deployment
nganalyze                      # Bundle analysis
```

### End of Day
```bash
devcleanup                     # Clean development environment
smartcommit "wip: end of day checkpoint"
git push origin feature/dashboard-stats
```

## Angular CLI Quick Reference

### Project Setup
```bash
ngnew my-app --routing --style=scss    # Create new project
nga @angular/material                   # Add Angular Material
ngu                                     # Update Angular packages
```

### Code Generation
```bash
# Components
ngc feature/user-profile
ngcp shared/loading-spinner             # with tests and scss
ngcs simple-button                      # skip tests, inline template

# Services & Modules
ngs core/auth-service
ngm features/dashboard --routing

# Other generators
ng g guard auth --implements CanActivate
ng g pipe shared/currency-format
ng g directive shared/highlight
ng g interface models/user
ng g enum shared/user-status
```

### Development & Testing
```bash
ngserve                                 # Development server
ngtest                                  # Unit tests
npm run e2e                            # E2E tests (if configured)
ngl                                    # Linting
ngbuild                                # Production build
```

### Environment Management
```bash
ng serve --configuration=staging
ng build --configuration=production
ng build --stats-json && npx webpack-bundle-analyzer dist/stats.json
```

## VS Code / Neovim Extensions for Angular

### Essential Extensions
- Angular Language Service
- Angular Snippets
- Auto Rename Tag
- Bracket Pair Colorizer
- ES7+ React/Redux/React-Native snippets
- GitLens
- Prettier
- ESLint
- Auto Import

### Neovim with LazyVim (included in your setup)
- TypeScript support
- Angular snippets
- Auto-completion with LSP
- GitHub Copilot
- File navigation with Telescope
- Git integration

## Daily Workflow Timeline

### 9:00 AM - Morning Setup
```bash
morning                    # Start tmux, check tools
cd ~/projects/angular-app
ngcheck                   # Verify project health
ngdev                     # Start development server
```

### 9:30 AM - Feature Development
```bash
newfeature user-dashboard
ngc features/user-dashboard
ngs services/dashboard-data
nvim .                    # Start coding with AI assistance
```

### 12:00 PM - Midday Check
```bash
smartcommit "feat(dashboard): add basic layout and service"
git push origin feature/user-dashboard
```

### 5:00 PM - End of Day
```bash
ngcheck                   # Final health check
smartcommit "wip: dashboard feature progress"
devcleanup               # Clean environment
```

## Troubleshooting Angular Issues

### Common Problems & Solutions
```bash
# Node modules issues
rm -rf node_modules package-lock.json
npm install

# Angular CLI issues
npm uninstall -g @angular/cli
npm install -g @angular/cli@latest

# Port already in use
ng serve --port 4201

# Memory issues during build
node --max_old_space_size=8192 ./node_modules/@angular/cli/bin/ng build

# Clear Angular cache
ng cache clean
```

### Debug Mode
```bash
ng serve --source-map=true
ng build --source-map=true
ng test --source-map=true --watch=true
```

## Performance Optimization

### Bundle Analysis
```bash
nganalyze                              # Bundle analyzer
ng build --stats-json
npm audit                              # Security audit
npm audit fix                          # Fix security issues
```

### Build Optimization
```bash
ng build --configuration=production --aot --build-optimizer
ng build --configuration=production --source-map=false
```

This reference integrates perfectly with your dotfiles setup and provides a streamlined Angular development workflow!
