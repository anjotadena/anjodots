-- Copilot initialization helper
-- This file provides commands to easily setup and check Copilot status

vim.api.nvim_create_user_command("CopilotInit", function()
  -- Check if Copilot is available
  if vim.fn.exists(":Copilot") ~= 2 then
    print("Copilot plugin not loaded. Please check your plugin configuration.")
    return
  end
  
  -- Check if the function exists before calling it
  if vim.fn.exists("*copilot#Enabled") == 1 then
    local status = vim.fn["copilot#Enabled"]()
    if status == 0 then
      print("Copilot is not authenticated. Running setup...")
      vim.cmd("Copilot setup")
    else
      print("Copilot is already set up and enabled!")
      vim.cmd("Copilot status")
    end
  else
    print("Copilot functions not yet available. Try running :Copilot setup directly.")
    vim.cmd("Copilot setup")
  end
end, {
  desc = "Initialize and setup GitHub Copilot",
})

vim.api.nvim_create_user_command("CopilotCheck", function()
  if vim.fn.exists(":Copilot") ~= 2 then
    print("❌ Copilot plugin not available")
    return
  end
  
  if vim.fn.exists("*copilot#Enabled") == 1 then
    local enabled = vim.fn["copilot#Enabled"]()
    if enabled == 1 then
      print("✅ Copilot is enabled and ready")
    else
      print("⚠️  Copilot is available but not enabled. Run :Copilot setup")
    end
  else
    print("⚠️  Copilot commands available but status functions not loaded yet")
  end
  7305-DFF3
  vim.cmd("Copilot status")
end, {
  desc = "Check GitHub Copilot status",
})
