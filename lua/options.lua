require "nvchad.options"

-- add yours here!
--
vim.wo.relativenumber = true
vim.wo.number = true

-- Disable word wrap (lines will scroll horizontally)
vim.o.wrap = false

-- Enable folding
vim.o.foldenable = true
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
vim.o.foldcolumn = '1'
vim.o.timeoutlen = 1000

local function detect_yaml_filetype(path, bufnr)
  local filepath = vim.fn.expand("%:p")
  
  if filepath:match "%.ytt%." then
    return "ytt"
  end
  
  if filepath:match "playbooks/" or filepath:match "roles/" or filepath:match "tasks/" then
    return "yaml.ansible"
  end
  
  if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
    local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, 50, false), "\n")
    if content:match "@ytt:" or content:match "%$%{" then
      return "ytt"
    end
    if content:match "apiVersion" and content:match "kind" then
      return "yaml.kubernetes"
    end
  end
  
  return "yaml"
end

vim.filetype.add {
  extension = {
    yml = function(path, bufnr)
      return detect_yaml_filetype(path, bufnr)
    end,
    yaml = function(path, bufnr)
      return detect_yaml_filetype(path, bufnr)
    end,
  },
  pattern = {
    [".*%.ytt%.yaml"] = "ytt",
    [".*%.ytt%.yml"] = "ytt",
  },
}

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
