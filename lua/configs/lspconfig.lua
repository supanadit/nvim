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
  "clangd",
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

local yaml_schemas = vim.deepcopy(require("schemastore").yaml.schemas())

local extra_schemas = {
  ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.29.0-standalone-strict/deployment.json"] = {
    "*.deployment.yaml",
    "*.statefulset.yaml",
    "*.daemonset.yaml",
    "*.replicaset.yaml",
    "*.pod.yaml",
    "*.service.yaml",
    "*.configmap.yaml",
    "*.secret.yaml",
    "*.ingress.yaml",
    "*.job.yaml",
    "*.cronjob.yaml",
    "*.k8s.yaml",
    "*.kubernetes.yaml",
    "kustomization.yaml",
    "kustomize.yaml",
  },
  ["https://json.schemastore.org/docker-compose.json"] = {
    "docker-compose.yaml",
    "docker-compose.yml",
    "compose.yaml",
    "compose.yml",
  },
}

for url, patterns in pairs(extra_schemas) do
  yaml_schemas[url] = patterns
end

vim.lsp.config("yamlls", {
  on_attach = function(client, bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 50, false)
    for _, line in ipairs(lines) do
      if line:match "^#@" or line:match "^#!" then
        vim.lsp.buf_detach_client(bufnr, client.id)
        return
      end
    end
    nvlsp.on_attach(client, bufnr)
  end,
  capabilities = nvlsp.capabilities,
  settings = {
    yaml = {
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      validate = true,
      format = {
        enable = true,
      },
      schemas = yaml_schemas,
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
