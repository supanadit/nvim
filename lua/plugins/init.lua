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
    "windwp/nvim-ts-autotag",
    ft = { "javascriptreact", "typescriptreact", "html" },
    config = function()
      require("nvim-ts-autotag").setup()
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
        "yaml",
        "c",
        "cpp",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
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
    -- Install markdown preview, use npx if available.
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function(plugin)
      if vim.fn.executable "npx" then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd [[Lazy load markdown-preview.nvim]]
        vim.fn["mkdp#util#install"]()
      end
    end,
    init = function()
      if vim.fn.executable "npx" then
        vim.g.mkdp_filetypes = { "markdown" }
      end
    end,
  },
  {
    "javiorfo/nvim-soil",

    -- Optional for puml syntax highlighting:
    dependencies = { "javiorfo/nvim-nyctophilia" },

    lazy = true,
    ft = "plantuml",
    opts = {
      -- If you want to change default configurations

      -- This option closes the image viewer and reopen the image generated
      -- When true this offers some kind of online updating (like plantuml web server)
      actions = {
        redraw = false,
      },

      -- If you want to use Plant UML jar version instead of the installed version
      puml_jar = "/home/supanadit/SDK/PlantUML/gplv2-1.2026.1.jar",

      -- If you want to customize the image showed when running this plugin
      image = {
        darkmode = false, -- Enable or disable darkmode
        format = "png", -- Choose between png or svg

        -- This is a default implementation of using nsxiv to open the resultant image
        -- Edit the string to use your preferred app to open the image (as if it were a command line)
        -- Some examples:
        -- return "feh " .. img
        -- return "xdg-open " .. img
        execute_to_open = function(img)
          return "nsxiv -b " .. img
        end,
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
      { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Search current word" },
      {
        "<leader>sp",
        '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
        desc = "Search in current file",
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "onlyati/quadlet-lsp.nvim",
    ft = { "systemd" }, -- This will load when you open your quadlet files
    opts = {},
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "ruff",
        "black",
        "clangd",
        "clang-format",
        "clang-tidy",
      },
    },
  },

  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<M-CR>", 'copilot#Accept("<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Accept Copilot suggestion",
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      mappings = {
        complete = {
          insert = "<C-Space>",
        },
      },
    },
  },

  -- YTT (Carvel) template support
  {
    "cappyzawa/starlark.vim",
    lazy = false,
  },
  {
    "vmware-tanzu/ytt.vim",
    lazy = false,
  },

  {
    "editorconfig/editorconfig-vim",
    lazy = false,
  },

  -- DAP for debugging
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      -- Basic C/C++ configuration using gdb
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
      }
      dap.configurations.cpp = {
        {
          name = "Launch file (gdb)",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = 'Attach to process',
          type = 'gdb',
          request = 'attach',
          processId = require('dap.utils').pick_process,
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
        },
      }
      dap.configurations.c = dap.configurations.cpp
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
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
