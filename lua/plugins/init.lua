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
        debugger = {
          enabled = true,
          run_via_dap = true,
          exception_breakpoints = {},
        },
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
        "js-debug-adapter",
        "delve",
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
      local dap = require "dap"
      -- Basic C/C++ configuration using gdb
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }

      -- Node.js configuration
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      -- Go (Delve) configuration
      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath "data" .. "/mason/bin/dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      -- Helper function to get npm scripts from package.json
      local function get_npm_scripts()
        local cwd = vim.fn.getcwd()
        local package_json_path = cwd .. "/package.json"
        local file = io.open(package_json_path, "r")
        if not file then
          return {}
        end
        local content = file:read "*a"
        file:close()
        local ok, decoded = pcall(vim.json.decode, content)
        if not ok or not decoded.scripts then
          return {}
        end
        local scripts = {}
        for name, _ in pairs(decoded.scripts) do
          table.insert(scripts, name)
        end
        table.sort(scripts)
        return scripts
      end

      -- Helper function to pick npm script
      local function pick_npm_script()
        local scripts = get_npm_scripts()
        if #scripts == 0 then
          vim.notify("No scripts found in package.json", vim.log.levels.WARN)
          return nil
        end
        local choice = nil
        vim.ui.select(scripts, {
          prompt = "Select npm script to debug:",
        }, function(selected)
          choice = selected
        end)
        -- Wait for selection (coroutine-based)
        if choice then
          return choice
        end
        return nil
      end

      dap.configurations.javascript = {
        {
          name = "Launch file",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          name = "Attach to process",
          type = "pwa-node",
          request = "attach",
          processId = require("dap.utils").pick_process,
        },
        {
          name = "Debug Jest tests",
          type = "pwa-node",
          request = "launch",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/jest/bin/jest.js",
            "--runInBand",
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
        {
          name = "npm script (from package.json)",
          type = "pwa-node",
          request = "launch",
          runtimeExecutable = "npm",
          runtimeArgs = function()
            local scripts = get_npm_scripts()
            if #scripts == 0 then
              vim.notify("No scripts found in package.json", vim.log.levels.WARN)
              return { "run", "start" }
            end
            local co = coroutine.running()
            local selected_script = nil
            vim.ui.select(scripts, {
              prompt = "Select npm script to debug:",
            }, function(selected)
              selected_script = selected
              if co then
                coroutine.resume(co)
              end
            end)
            if co then
              coroutine.yield()
            end
            if selected_script then
              return { "run", selected_script, "--", "--inspect" }
            end
            return { "run", "start" }
          end,
          cwd = "${workspaceFolder}",
          protocol = "inspector",
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**" },
        },
      }
      dap.configurations.typescript = dap.configurations.javascript
      dap.configurations.json = dap.configurations.javascript

      -- Go configurations
      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug Package",
          request = "launch",
          program = "${fileDirname}",
        },
        {
          type = "delve",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
        {
          type = "delve",
          name = "Attach to process",
          request = "attach",
          mode = "local",
          processId = require("dap.utils").pick_process,
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "tris203/precognition.nvim",
    -- Load only when you actually start editing to avoid the E565 error
    event = "VeryLazy",
    opts = {
      -- You can start with it disabled if the error persists
      -- startVisible = false,
    },
  },
  {
    "chrisgrieser/nvim-spider",
    -- Remove the dependency line here; they will find each other via 'opts'
    lazy = true,
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" }, desc = "Spider-w" },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" }, desc = "Spider-e" },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" }, desc = "Spider-b" },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      labels = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
      modes = {
        search = {
          enabled = true,
        },
        char = {
          jump_labels = true,
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
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
