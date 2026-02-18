require "nvchad.options"

-- add yours here!
--
vim.wo.relativenumber = true
vim.wo.number = true

-- Enable folding
vim.o.foldenable = true
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
vim.o.foldcolumn = '1'

vim.filetype.add {
  extension = {
    yml = function(path, bufnr)
      return is_ansible(path, bufnr) and "yaml.ansible" or "yaml"
    end,
    yaml = function(path, bufnr)
      return is_ansible(path, bufnr) and "yaml.ansible" or "yaml"
    end,
  },
  pattern = {
    [".*%.ytt%.yaml"] = "ytt",
    [".*%.ytt%.yml"] = "ytt",
  },
}

function is_ansible(path, bufnr)
  -- Detect based on directory name or file content
  local filepath = vim.fn.expand "%:p"
  if filepath:match "playbooks/" or filepath:match "roles/" or filepath:match "tasks/" then
    return true
  end
  return false
end

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
