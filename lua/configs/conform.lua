local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd" },
    ansible = { "ansible-lint" },
    terraform = { "terraform_fmt" },
    hcl = { "terraform_fmt" },
    go = { "goimports", "gofumpt" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    dockerfile = { "prettierd" },
    markdown = { "prettierd" },
    json = { "prettierd" },
    toml = { "taplo" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd", "eslint_d" },
    typescriptreact = { "prettierd", "eslint_d" },
    python = { "black" },
    c = { "clang_format" },
    cpp = { "clang_format" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
