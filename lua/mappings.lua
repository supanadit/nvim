require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-d>", "m`yyp``", { desc = "Duplicate line (keep cursor)" })
-- Debugger for Golang
map("n", "<leader>gt", "<cmd> lua require('dap-go').debug_test() <CR>", { desc = "Debug Go Test" })
map("n", "<leader>gl", "<cmd> lua require('dap-go').debug_last_test() <CR>", { desc = "Debug Last Go Test" })

map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
-- YTT plugin mappings (remapped to avoid conflict with nvim-tree <Leader>e)
map("n", "<leader>te", "<cmd>EnableYtt<CR>", { desc = "Enable YTT syntax" })
map("n", "<leader>td", "<cmd>DisableYtt<CR>", { desc = "Disable YTT syntax" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
