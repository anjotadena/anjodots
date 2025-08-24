-- Aggressive ESC fix for Snacks.nvim picker
-- This file forcefully ensures ESC works in the file picker

-- Wait for Snacks to load, then override its behavior
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.schedule(function()
      -- Try to patch Snacks picker directly
      local ok, snacks = pcall(require, "snacks")
      if not ok then
        return
      end
      
      -- Override the file picker function
      local original_files = snacks.picker.files
      snacks.picker.files = function(...)
        -- Call original function
        local result = original_files(...)
        
        -- Add ESC handling after picker opens
        vim.defer_fn(function()
          -- Find the picker window
          local wins = vim.api.nvim_list_wins()
          for _, win in ipairs(wins) do
            local config = vim.api.nvim_win_get_config(win)
            if config.relative ~= "" then -- floating window
              local buf = vim.api.nvim_win_get_buf(win)
              
              -- Force ESC mapping on this buffer
              vim.keymap.set({ "i", "n" }, "<Esc>", function()
                vim.api.nvim_win_close(win, false)
              end, { buffer = buf, silent = true, nowait = true })
              
              vim.keymap.set({ "i", "n" }, "<C-c>", function()
                vim.api.nvim_win_close(win, false)
              end, { buffer = buf, silent = true, nowait = true })
              
              vim.keymap.set("n", "q", function()
                vim.api.nvim_win_close(win, false)
              end, { buffer = buf, silent = true, nowait = true })
            end
          end
        end, 50) -- Small delay to ensure picker is fully loaded
        
        return result
      end
      
      -- Global ESC handler as ultimate fallback
      vim.keymap.set("n", "<Esc>", function()
        -- Check all windows for floating ones and close them
        local wins = vim.api.nvim_list_wins()
        local closed_any = false
        
        for _, win in ipairs(wins) do
          local config = vim.api.nvim_win_get_config(win)
          if config.relative ~= "" then -- floating window
            pcall(vim.api.nvim_win_close, win, false)
            closed_any = true
          end
        end
        
        if not closed_any then
          -- No floating windows, clear search highlights
          vim.cmd("nohlsearch")
        end
      end, { desc = "Close floating windows" })
      
      -- Also override the Space+Space mapping to ensure it works
      vim.keymap.set("n", "<leader><leader>", function()
        snacks.picker.files()
      end, { desc = "Find Files (Snacks)" })
    end)
  end,
})

-- Immediate ESC handler for any current floating windows
vim.keymap.set({ "i", "n" }, "<Esc>", function()
  local wins = vim.api.nvim_list_wins()
  for _, win in ipairs(wins) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then -- floating window
      pcall(vim.api.nvim_win_close, win, false)
      return
    end
  end
  
  -- If in insert mode, go to normal mode first
  if vim.api.nvim_get_mode().mode == "i" then
    vim.cmd("stopinsert")
  else
    vim.cmd("nohlsearch")
  end
end, { desc = "Close floating or escape insert" })

-- Buffer-enter autocmd as backup
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(event)
    local buf = event.buf
    local win = vim.api.nvim_get_current_win()
    local config = vim.api.nvim_win_get_config(win)
    
    -- If this is a floating window, add ESC mapping
    if config.relative ~= "" then
      vim.keymap.set({ "i", "n" }, "<Esc>", function()
        pcall(vim.api.nvim_win_close, win, false)
      end, { buffer = buf, silent = true, nowait = true })
      
      vim.keymap.set("n", "q", function()
        pcall(vim.api.nvim_win_close, win, false)
      end, { buffer = buf, silent = true, nowait = true })
    end
  end,
})
