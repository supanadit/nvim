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

-- Delete in Visual Mode without yanking to clipboard
map("v", "d", '"_d')
map("v", "D", '"_D')
map("v", "c", '"_c')
map("v", "C", '"_C')

-- The "Greatest Move": Paste over highlighted text without losing your original yank
map("v", "p", '"_dP')

-- Open chat for the current selection
map("v", "<leader>ai", function()
  local input = vim.fn.input "Chat about selection: "
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
  end
end, { desc = "CopilotChat - Selection" })

-- Quick chat for the whole buffer
map("n", "<leader>ai", function()
  local input = vim.fn.input "Quick Chat: "
  if input ~= "" then
    require("CopilotChat").ask(input)
  end
end, { desc = "CopilotChat - Quick chat" })

-- Open CopilotChat window directly (use #buffer or #file in chat to add context)
map("n", "<leader>ao", function()
  require("CopilotChat").open()
end, { desc = "CopilotChat - Open" })
