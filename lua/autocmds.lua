require "nvchad.autocmds"

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "yaml.ansible", "yaml.kubernetes", "yaml.docker-compose", "ytt" },
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.foldlevel = 99
    vim.opt_local.foldnestmax = 10
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml.ansible", "yaml.kubernetes", "yaml.docker-compose" },
  callback = function()
    vim.cmd("runtime! syntax/yaml.vim")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ytt",
  callback = function()
    vim.cmd("runtime! syntax/yaml.vim")
    if vim.fn.exists(":EnableYtt") == 2 then
      vim.cmd("EnableYtt")
    end
    vim.cmd("silent! highlight default link yamlComment Comment")
    vim.cmd("silent! highlight default link yttDirective PreProc")
    vim.cmd("silent! highlight default link yttComment Comment")
  end,
})

-- Disable Tab buffer switching in CopilotChat
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "copilot-chat",
--   callback = function()
--     vim.keymap.set("n", "<Tab>", "<Nop>", { buffer = true })
--     vim.keymap.set("n", "<S-Tab>", "<Nop>", { buffer = true })
--   end,
-- })

require("devcontainer").setup{}
