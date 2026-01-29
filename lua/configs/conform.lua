local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
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
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
