require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

local capabilities = nvlsp.capabilities

-- Define the servers you want
local servers = {
  "html",
  "cssls",
  "ts_ls",
  "eslint",
  "tailwindcss",
  "yamlls",
  "ansiblels",
  "terraformls",
  "tflint",
  "gopls",
  "bashls",
  "dockerls",
  "marksman",
  "jsonls",
  "taplo",
  "pyright",
}

local skip_setup = { yamlls = true, ansiblels = true, terraformls = true, gopls = true, bashls = true }

for _, lsp in ipairs(servers) do
  if not skip_setup[lsp] then
    vim.lsp.config(lsp, {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    })
  end
end

vim.lsp.config("yamlls", {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  settings = {
    yaml = {
      schemas = {
        -- This tells the LSP: "If the file is YAML, use Kubernetes rules"
        ["kubernetes"] = "*.yaml",
        -- You can also add specific patterns for other things:
        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
      },
    },
  },
})

vim.lsp.config("ansiblels", {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  settings = {
    ansible = {
      ansible = { path = "ansible" },
      ansibleLint = { enabled = true, path = "ansible-lint" },
      executionEnvironment = { enabled = false },
      python = { interpreterPath = "python3" },
    },
  },
})

vim.lsp.config("terraformls", {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  -- This ensures the LSP starts for both .tf and .hcl files
  filetypes = { "terraform", "terraform-vars", "hcl" },
})

vim.lsp.config("gopls", {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true, -- A stricter gofmt
    },
  },
})

vim.lsp.config("bashls", {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "sh", "zsh", "bash" },
})

vim.lsp.config("jsonls", {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

vim.lsp.config("tailwindcss", {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "html", "javascriptreact", "typescriptreact", "css" },
})

vim.lsp.enable(servers)
