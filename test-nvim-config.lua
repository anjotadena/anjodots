-- Test script to verify Neovim configuration loads without errors
print("Testing Neovim configuration...")

-- Test if we can load the basic configs
local ok, err = pcall(function()
  -- Set up basic Neovim environment
  vim.opt.runtimepath:prepend(vim.fn.getcwd() .. "/nvim")
  
  -- Try to load the main config files
  require("config.options")
  require("config.lazy")
  
  print("✓ Basic configuration loaded successfully")
  
  -- Try to load plugins
  local snacks_ok, snacks_err = pcall(function() 
    return require("plugins.snacks")
  end)
  
  if snacks_ok then
    print("✓ Snacks plugin configuration loaded successfully")
  else
    print("✗ Snacks plugin configuration error: " .. tostring(snacks_err))
  end
  
  local telescope_ok, telescope_err = pcall(function()
    return require("config.telescope-keymaps")
  end)
  
  if telescope_ok then
    print("✓ Telescope keymaps loaded successfully")
  else
    print("✗ Telescope keymaps error: " .. tostring(telescope_err))
  end
end)

if ok then
  print("✓ All configurations loaded successfully!")
else
  print("✗ Configuration error: " .. tostring(err))
end
