require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map("n", "<C-d>", "m`yyp``", { desc = "Duplicate line (keep cursor)" })

-- General Debugger mappings
map("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>", { desc = "Debug Continue" })
map("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
map("n", "<leader>do", "<cmd>lua require('dap').step_over()<CR>", { desc = "Step Over" })
map("n", "<leader>di", "<cmd>lua require('dap').step_into()<CR>", { desc = "Step Into" })
map("n", "<leader>du", "<cmd>lua require('dap').step_out()<CR>", { desc = "Step Out" })
map("n", "<leader>dt", "<cmd>lua require('dap').terminate()<CR>", { desc = "Terminate Debug" })
map("n", "<leader>dU", "<cmd>lua require('dapui').toggle()<CR>", { desc = "Toggle DAP UI" })
map("n", "<leader>dr", "<cmd>lua require('dap').repl.open()<CR>", { desc = "Open DAP REPL" })

map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })

-- LSP Code Actions (Quick Fix - like VSCode's lightbulb popup)
map("n", "<A-c>", vim.lsp.buf.code_action, { desc = "LSP Code Action (Quick Fix)" })

-- EasyMotion Mappings
-- Jump to anywhere with 2 characters (Similar to 's' in other plugins)
map("n", "<leader><leader>s", "<Plug>(easymotion-sn)", { desc = "EasyMotion: 2-char search" })

-- Jump to word (forward/backward)
map("n", "<leader><leader>w", "<Plug>(easymotion-overwin-w)", { desc = "EasyMotion: Jump to word" })

-- Line motions (very useful for vertical navigation)
map("n", "<leader><leader>j", "<Plug>(easymotion-j)", { desc = "EasyMotion: Jump down lines" })
map("n", "<leader><leader>k", "<Plug>(easymotion-k)", { desc = "EasyMotion: Jump up lines" })

-- Target-based search (Type / then your target, then pick the label)
map("n", "<leader><leader>/", "<Plug>(easymotion-tn)", { desc = "EasyMotion: Search target" })

-- Flutter mappings
map("n", "<leader>Fd", function()
  local device = vim.fn.input("Device (linux/chrome): ", "linux")
  if device ~= "" then
    vim.cmd("FlutterRun -d " .. device)
  end
end, { desc = "Flutter Run with device" })
map("n", "<leader>Fq", "<cmd>FlutterQuit<CR>", { desc = "Flutter Quit" })
map("n", "<leader>Fr", "<cmd>FlutterRestart<CR>", { desc = "Flutter Restart" })
map("n", "<leader>Fl", "<cmd>FlutterLogClear<CR>", { desc = "Flutter Log Clear" })
map("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<CR>", { desc = "Flutter Outline Toggle" })
map("n", "<leader>FD", "<cmd>FlutterDevices<CR>", { desc = "Flutter Devices" })

-- YTT plugin mappings (remapped to avoid conflict with nvim-tree <Leader>e)
map("n", "<leader>te", "<cmd>EnableYtt<CR>", { desc = "Enable YTT syntax" })
map("n", "<leader>td", "<cmd>DisableYtt<CR>", { desc = "Disable YTT syntax" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Delete in Visual Mode without yanking to clipboard
map("v", "d", '"_d')
map("v", "D", '"_D')
map("v", "c", '"_c')
map("v", "C", '"_C')

-- Delete in Normal Mode without yanking to clipboard
map("n", "dd", '"_dd')
map("n", "D", '"_D')
map("n", "x", '"_x')

-- The "Greatest Move": Paste over highlighted text without losing your original yank
map("v", "p", '"_dP')

-- Open chat for the current selection
-- map("v", "<leader>ai", function()
--   local input = vim.fn.input "Chat about selection: "
--   if input ~= "" then
--     require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
--   end
-- end, { desc = "CopilotChat - Selection" })
--
-- -- Quick chat for the whole buffer
-- map("n", "<leader>ai", function()
--   local input = vim.fn.input "Quick Chat: "
--   if input ~= "" then
--     require("CopilotChat").ask(input)
--   end
-- end, { desc = "CopilotChat - Quick chat" })
--
-- -- Open CopilotChat window directly (use #buffer or #file in chat to add context)
-- map("n", "<leader>ao", function()
--   require("CopilotChat").open()
-- end, { desc = "CopilotChat - Open" })
