-- Development plugins for Angular, React, Python, Go
-- Add any additional plugins, language servers, tools, etc.

return {
  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
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
      vim.list_extend(opts.ensure_installed, {
        -- Additional tools not covered by language extras
        "black",
        "flake8", 
        "gofumpt",
        "delve",
      })
    end,
  },

  -- TypeScript utilities (additional tools)
  {
    "pmizio/typescript-tools.nvim",
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
