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

-- Auto-fix Go imports after renaming files/folders in nvim-tree
local ok, nvim_tree_api = pcall(require, "nvim-tree.api")
if ok then
  nvim_tree_api.events.subscribe(nvim_tree_api.events.Event.NodeRenamed, function(data)
    local old_name = data.old_name or ""
    local new_name = data.new_name or ""

    -- Check if this is a Go project (go.mod exists in workspace root)
    local cwd = vim.fn.getcwd()
    local go_mod_path = cwd .. "/go.mod"
    if vim.fn.filereadable(go_mod_path) ~= 1 then
      return
    end

    -- Check if renamed item is a Go file or a directory
    local is_go_file = old_name:match("%.go$") or new_name:match("%.go$")
    local is_dir = vim.fn.isdirectory(new_name) == 1

    if not (is_go_file or is_dir) then
      return
    end

    -- Read module name from go.mod
    local module_name = nil
    for line in io.lines(go_mod_path) do
      module_name = line:match("^module%s+(%S+)")
      if module_name then
        break
      end
    end

    if not module_name then
      vim.schedule(function()
        vim.notify("Could not find module name in go.mod", vim.log.levels.WARN)
      end)
      return
    end

    -- Calculate old and new import paths (only for directory renames)
    if is_dir then
      local old_relative = old_name:sub(#cwd + 2) -- Remove cwd/ prefix
      local new_relative = new_name:sub(#cwd + 2)

      local old_import = module_name .. "/" .. old_relative
      local new_import = module_name .. "/" .. new_relative

      -- First: replace import paths in all Go files using shell
      local shell_cmd = "find . -name '*.go' -exec sed -i 's|" .. old_import .. "|" .. new_import .. "|g' {} +"
      vim.system(
        { "sh", "-c", shell_cmd },
        { cwd = cwd },
        function(sed_result)
          vim.schedule(function()
            if sed_result.code == 0 then
              vim.notify("Updated imports: " .. old_import .. " -> " .. new_import, vim.log.levels.INFO)

              -- Then run goimports to clean up
              vim.system({ "goimports", "-w", "." }, { cwd = cwd }, function(imports_result)
                vim.schedule(function()
                  if imports_result.code == 0 then
                    vim.notify("goimports: imports organized", vim.log.levels.INFO)
                    -- Reload all open Go buffers
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                      if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "go" then
                        vim.cmd("checktime")
                      end
                    end
                  else
                    vim.notify("goimports failed: " .. (imports_result.stderr or "unknown error"), vim.log.levels.WARN)
                  end
                end)
              end)
            else
              vim.notify("Failed to update imports: " .. (sed_result.stderr or "unknown error"), vim.log.levels.WARN)
            end
          end)
        end
      )
    else
      -- For file renames, just run goimports
      vim.system({ "goimports", "-w", "." }, { cwd = cwd }, function(result)
        vim.schedule(function()
          if result.code == 0 then
            vim.notify("goimports: imports organized", vim.log.levels.INFO)
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "go" then
                vim.cmd("checktime")
              end
            end
          else
            vim.notify("goimports failed: " .. (result.stderr or "unknown error"), vim.log.levels.WARN)
          end
        end)
      end)
    end
  end)
end
