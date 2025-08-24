#!/bin/bash

# Neovim Configuration Checker
# Usage: ./nvim-check.sh

echo "Checking Neovim Configuration..."
echo "================================="

# Check basic startup
echo "1. Testing basic startup..."
if nvim --headless +quit 2>/dev/null; then
    echo "   Basic startup: OK"
else
    echo "   Basic startup: FAILED"
    echo "   Error details:"
    nvim --headless +quit 2>&1 | sed 's/^/     /'
    exit 1
fi

# Check init.lua
echo "2. Testing init.lua..."
if nvim --headless +'lua print("Init test")' +quit 2>/dev/null; then
    echo "   init.lua: OK"
else
    echo "   init.lua: FAILED"
    echo "   Error details:"
    nvim --headless +'lua print("Init test")' +quit 2>&1 | sed 's/^/     /'
fi

# Check Lazy plugin manager
echo "3. Testing Lazy plugin manager..."
if nvim --headless +'lua require("lazy")' +quit 2>/dev/null; then
    echo "   Lazy: OK"
else
    echo "   Lazy: FAILED"
    echo "   Error details:"
    nvim --headless +'lua require("lazy")' +quit 2>&1 | sed 's/^/     /'
fi

# Check custom Copilot commands
echo "4. Testing custom commands..."
if nvim --headless +'CopilotCheck' +quit 2>/dev/null; then
    echo "   Custom commands: OK"
else
    echo "   Custom commands: FAILED"
    echo "   Error details:"
    nvim --headless +'CopilotCheck' +quit 2>&1 | sed 's/^/     /'
fi

# Check configuration files exist
echo "5. Checking configuration files..."
config_files=(
    "~/.config/nvim/init.lua"
    "~/.config/nvim/lua/config/lazy.lua"
    "~/.config/nvim/lua/config/copilot-init.lua"
    "~/.config/nvim/lua/plugins/dev.lua"
)

for file in "${config_files[@]}"; do
    expanded_file=$(eval echo $file)
    if [ -f "$expanded_file" ]; then
        echo "   $file: EXISTS"
    else
        echo "   $file: MISSING"
    fi
done

echo
echo "Configuration check complete!"
echo "If any errors were found, check the DEBUG.md file for troubleshooting tips."
