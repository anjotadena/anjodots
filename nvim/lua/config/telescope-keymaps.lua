-- Simple ESC fix for LazyVim Snacks.nvim picker
-- Remove Telescope dependencies to avoid loading errors

-- Global ESC handler that works with any floating window
vim.keymap.set("n", "<Esc>", function()
  -- Get current window
  local win = vim.api.nvim_get_current_win()
  local config = vim.api.nvim_win_get_config(win)
  
  -- If we're in a floating window, close it
  if config.relative ~= "" then
    vim.api.nvim_win_close(win, false)
    return
  end
  
  -- Check all windows for floating Snacks pickers
  local wins = vim.api.nvim_list_wins()
  for _, w in ipairs(wins) do
    local win_config = vim.api.nvim_win_get_config(w)
    if win_config.relative ~= "" then -- floating window
      vim.api.nvim_win_close(w, false)
      return
    end
  end
  
  -- Default: clear search highlights
  vim.cmd("nohlsearch")
end, { desc = "Close Floating Windows or Clear Search" })

-- Simple autocmd for any Snacks-related buffers
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(event)
    local buf = event.buf
    local buf_name = vim.api.nvim_buf_get_name(buf)
    
    -- Check if this looks like a Snacks picker
    if buf_name:match("snacks") or vim.bo[buf].filetype:match("snacks") then
      -- Set simple buffer-local ESC mapping
      vim.keymap.set({ "i", "n" }, "<Esc>", function()
        local current_win = vim.api.nvim_get_current_win()
        if vim.api.nvim_win_is_valid(current_win) then
          vim.api.nvim_win_close(current_win, false)
        end
      end, { buffer = buf, silent = true, nowait = true })
      
      -- Also map q and Ctrl+C
      vim.keymap.set("n", "q", function()
        local current_win = vim.api.nvim_get_current_win()
        if vim.api.nvim_win_is_valid(current_win) then
          vim.api.nvim_win_close(current_win, false)
        end
      end, { buffer = buf, silent = true })
      
      vim.keymap.set({ "i", "n" }, "<C-c>", function()
        local current_win = vim.api.nvim_get_current_win()
        if vim.api.nvim_win_is_valid(current_win) then
          vim.api.nvim_win_close(current_win, false)
        end
      end, { buffer = buf, silent = true })
    end
  end,
})
