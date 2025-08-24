-- Development plugins for Angular, React, Python, Go
-- Add any additional plugins, language servers, tools, etc.

return {
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
