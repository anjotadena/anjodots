# Neovim Configuration Debugging Guide

## Quick Error Checking Commands

### 1. Basic Syntax Check
```bash
# Test Neovim startup for errors
nvim --headless +quit 2>&1

# Test with minimal output
nvim --headless +'lua print("Test")' +quit 2>&1
```

### 2. Check Specific Files
```bash
# Test a specific Lua file
nvim --headless +'luafile ~/.config/nvim/lua/config/lazy.lua' +quit 2>&1

# Test init.lua specifically
nvim --headless +'source ~/.config/nvim/init.lua' +quit 2>&1
```

### 3. In Neovim Debugging Commands
```vim
" Check for Lua errors
:lua vim.print("Testing Lua")

" Check loaded modules
:lua print(package.loaded)

" Reload a module (useful during development)
:lua package.loaded['config.copilot-init'] = nil
:lua require('config.copilot-init')

" Check plugin status
:Lazy
:Mason
:LspInfo

" Check key mappings
:map
:nmap
:imap

" Check autocommands
:autocmd

" Check current configuration
:set
:lua print(vim.inspect(vim.g))
```

### 4. Log Files to Check
```bash
# Neovim log file
tail -f ~/.local/state/nvim/log

# Lazy plugin manager logs
# Check :Lazy for plugin-specific logs

# Mason logs
# Check :Mason for LSP installation logs
```

### 5. Common Error Patterns

#### Syntax Errors in Lua
- Missing commas, quotes, or brackets
- Unexpected characters (like the "7305-DFF3" we just fixed)
- Wrong indentation in table definitions

#### Plugin Loading Errors
- Missing dependencies
- Incorrect plugin specifications
- Version conflicts

#### LSP/Mason Errors
- Missing language servers
- Incorrect LSP configurations
- Path issues

### 6. Safe Testing Approach
```bash
# Backup current config
cp -r ~/.config/nvim ~/.config/nvim.backup

# Test changes incrementally
nvim --headless +quit 2>&1

# If errors occur, restore backup
# rm -rf ~/.config/nvim && mv ~/.config/nvim.backup ~/.config/nvim
```

### 7. Debugging Specific Components

#### LazyVim Issues
```vim
:Lazy
" Press 'l' to see logs
" Press 'u' to update
" Press 'c' to check
```

#### Copilot Issues
```vim
:Copilot status
:CopilotCheck
:Copilot log
```

#### LSP Issues
```vim
:LspInfo
:LspLog
:Mason
```

### 8. Performance Debugging
```vim
" Check startup time
:StartupTime

" Profile startup
" nvim --startuptime startup.log

" Check which plugins are slow
:Lazy profile
```

## Prevention Tips

1. **Always test after changes**: Run `nvim --headless +quit 2>&1` after configuration changes
2. **Use version control**: Commit working configurations before major changes  
3. **Test incrementally**: Add one plugin or configuration at a time
4. **Keep backups**: Backup working configurations before updates
5. **Check logs regularly**: Monitor `:messages` and log files for warnings
