require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

local capabilities = nvlsp.capabilities

-- Define the servers you want
local servers = { "html", "cssls", "ts_ls", "yamlls", "ansiblels", "terraformls", "tflint" }

for _, lsp in ipairs(servers) do
  if lsp ~= "yamlls" and lsp ~= "ansiblels" and lsp ~= "terraformls" then
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

vim.lsp.enable(servers)
