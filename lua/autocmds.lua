require "nvchad.autocmds"

-- YAML folding
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.foldlevel = 99
  end,
})
