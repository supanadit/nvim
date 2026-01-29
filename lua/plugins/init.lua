return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "b0o/SchemaStore.nvim",
    lazy = true,
  },

  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua", -- Ensures it hooks into NvimTree
    },
    event = "LspAttach",
    config = function()
      require("lsp-file-operations").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "typescript",
        "tsx",
        "javascript",
        "dart",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "bash",
        "dockerfile",
        "json",
        "jsonc",
        "toml",
      },
    },
  },

  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- Optional: for better UI prompts
    },

    config = function()
      require("flutter-tools").setup {
        lsp = {
          on_attach = require("nvchad.configs.lspconfig").on_attach,
          capabilities = require("nvchad.configs.lspconfig").capabilities,
          color_render = true, -- Shows colors in code
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
          },
        },
        dev_log = {
          enabled = true,
          open_cmd = "tabedit", -- opens logs in a new tab
        },
        widget_guides = {
          enabled = true, -- gives you those vertical lines for UI nesting
        },
      }
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("render-markdown").setup {}
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install", -- Manually trigger the npm install
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
