require "nvchad.autocmds"

-- YAML folding
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.foldlevel = 99
    vim.opt_local.foldnestmax = 10
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

-- Auto-enable ytt syntax for *.ytt.yaml files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.ytt.yaml", "*.ytt.yml" },
  callback = function()
    vim.cmd("set filetype=ytt")
    -- Wait a bit for plugins to load, then enable ytt syntax
    vim.defer_fn(function()
      if vim.fn.exists(":EnableYtt") == 2 then
        -- Load yaml syntax first, then enable ytt
        vim.cmd("runtime! syntax/yaml.vim")
        vim.cmd("EnableYtt")
      end
    end, 100)
  end,
})

-- Disable Tab buffer switching in CopilotChat
vim.api.nvim_create_autocmd("FileType", {
  pattern = "copilot-chat",
  callback = function()
    vim.keymap.set("n", "<Tab>", "<Nop>", { buffer = true })
    vim.keymap.set("n", "<S-Tab>", "<Nop>", { buffer = true })
  end,
})
