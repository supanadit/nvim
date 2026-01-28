require "nvchad.options"

-- add yours here!
--
vim.filetype.add {
  extension = {
    yml = function(path, bufnr)
      return is_ansible(path, bufnr) and "yaml.ansible" or "yaml"
    end,
    yaml = function(path, bufnr)
      return is_ansible(path, bufnr) and "yaml.ansible" or "yaml"
    end,
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
