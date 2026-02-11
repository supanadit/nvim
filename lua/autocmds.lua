require "nvchad.autocmds"

-- YAML folding
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.foldlevel = 99
  end,
})

-- YTT support: Create missing highlight groups and load vim syntax for ytt.vim plugin
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "yml" },
  callback = function()
    -- Load vim's built-in yaml syntax (required for ytt.vim)
    vim.cmd("runtime! syntax/yaml.vim")
    -- Create highlight groups that ytt.vim expects
    vim.cmd("silent! highlight default link yamlComment Comment")
    vim.cmd("silent! highlight default link yttDirective PreProc")
    vim.cmd("silent! highlight default link yttComment Comment")
  end,
})
