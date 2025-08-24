-- Development plugins for Angular, React, Python, Go
-- Add any additional plugins, language servers, tools, etc.

return {
  -- GitHub Copilot
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = { "InsertEnter", "VeryLazy" },
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      
      -- Auto-setup on first load
      vim.api.nvim_create_autocmd("VimEnter", {
        pattern = "*",
        callback = function()
          vim.defer_fn(function()
            if vim.fn.exists(":Copilot") == 2 then
              -- Check if already authenticated
              local status = vim.fn["copilot#Enabled"]()
              if status == 0 then
                print("GitHub Copilot is available. Run ':Copilot setup' to authenticate.")
              end
            end
          end, 1000)
        end,
        once = true,
      })
    end,
    keys = {
      {
        "<Tab>",
        function()
          if vim.fn["copilot#Accept"]("") ~= "" then
            return vim.fn["copilot#Accept"]("")
          else
            return "<Tab>"
          end
        end,
        mode = "i",
        expr = true,
        silent = true,
        desc = "Copilot Accept",
      },
      { "<C-]>", "<cmd>Copilot panel<cr>", mode = "i", desc = "Copilot Panel" },
      { "<C-\\>", "<cmd>Copilot disable<cr>", mode = "i", desc = "Copilot Disable" },
      { "<C-[>", "<cmd>Copilot enable<cr>", mode = "i", desc = "Copilot Enable" },
      { "<leader>cs", "<cmd>Copilot setup<cr>", desc = "Copilot Setup" },
      { "<leader>cp", "<cmd>Copilot panel<cr>", desc = "Copilot Panel" },
      { "<leader>ce", "<cmd>Copilot enable<cr>", desc = "Copilot Enable" },
      { "<leader>cd", "<cmd>Copilot disable<cr>", desc = "Copilot Disable" },
      { "<leader>cS", "<cmd>Copilot status<cr>", desc = "Copilot Status" },
    },
  },

  -- Alternative: Copilot.lua (more modern implementation)
  {
    "zbirenbaum/copilot.lua",
    enabled = false, -- Disable by default, enable if you prefer this over copilot.vim
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 18.x
        server_opts_overrides = {},
      })
    end,
  },

  -- Mason auto-install additional packages
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- Only add packages that aren't already installed by LazyVim extras
      local additional_tools = {
        "black",
        "flake8", 
        "gofumpt",
        "delve",
      }
      
      -- Check if tools are already in the list before adding
      for _, tool in ipairs(additional_tools) do
        if not vim.tbl_contains(opts.ensure_installed, tool) then
          table.insert(opts.ensure_installed, tool)
        end
      end
      
      return opts
    end,
  },

  -- TypeScript utilities (additional tools)
  {
    "pmizio/typescript-tools.nvim",
    enabled = false, -- Disable to avoid conflicts with LazyVim's TypeScript setup
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    keys = {
      { "<leader>rf", "<cmd>TSToolsRenameFile<cr>", desc = "Rename File" },
      { "<leader>oi", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize Imports" },
      { "<leader>ai", "<cmd>TSToolsAddMissingImports<cr>", desc = "Add Missing Imports" },
    },
  },

  -- Go enhanced tools
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    config = function()
      require("go").setup({
        gofmt = "gofumpt",
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    keys = {
      { "<leader>gt", "<cmd>GoTest<cr>", desc = "Go Test" },
      { "<leader>gr", "<cmd>GoRun<cr>", desc = "Go Run" },
      { "<leader>gb", "<cmd>GoBuild<cr>", desc = "Go Build" },
    },
  },

  -- Python DAP
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      require("dap-python").setup("python3")
    end,
    keys = {
      { "<leader>dt", function() require("dap-python").test_method() end, desc = "Debug Test Method" },
      { "<leader>dc", function() require("dap-python").test_class() end, desc = "Debug Test Class" },
    },
  },
}
