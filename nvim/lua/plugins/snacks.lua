return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      picker = {
        enabled = true,
        win = {
          backdrop = {
            enabled = true,
          },
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "i", "n" } },
              ["<C-c>"] = { "close", mode = { "i", "n" } },
              ["q"] = { "close", mode = { "n" } },
            }
          },
        }
      }
    },
    config = function(_, opts)
      require("snacks").setup(opts)
      
      -- Direct approach: override the picker's keymap setup
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Force ESC mapping after everything loads
          vim.schedule(function()
            -- Global escape for any floating window
            vim.keymap.set("n", "<Esc>", function()
              local wins = vim.api.nvim_list_wins()
              for _, win in ipairs(wins) do
                local config = vim.api.nvim_win_get_config(win)
                if config.relative ~= "" then -- floating window
                  pcall(vim.api.nvim_win_close, win, false)
                  return
                end
              end
              vim.cmd("nohlsearch")
            end, { desc = "Close floating window" })
            
            -- Override Space+Space to add ESC handling
            vim.keymap.set("n", "<leader><leader>", function()
              require("snacks").picker.files()
              
              -- Add ESC handler after picker opens
              vim.schedule(function()
                local current_buf = vim.api.nvim_get_current_buf()
                vim.keymap.set({ "i", "n" }, "<Esc>", function()
                  local win = vim.api.nvim_get_current_win()
                  pcall(vim.api.nvim_win_close, win, false)
                end, { buffer = current_buf, silent = true, nowait = true })
              end)
            end, { desc = "Find Files" })
          end)
        end,
      })
    end,
  }
}
