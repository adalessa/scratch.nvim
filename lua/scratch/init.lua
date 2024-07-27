local config = require("scratch.config")

local M = {}

---@param opts? ScratchOptions
function M.setup(opts)
  config.setup(opts)

  vim.fn.mkdir(config.options.path, 'p')

  local group = vim.api.nvim_create_augroup("scratch", {})
  vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = config.options.path .. "/*",
    group = group,
    callback = function(ev)
      vim.keymap.set('n', config.options.local_map, M.save_and_exec, { buffer = ev.buf, silent = true })
    end
  })
end

function M.new(prompt_bufnr)
  local action_state = require "telescope.actions.state"
  local actions = require "telescope.actions"

  local new_scratch = action_state.get_current_line()
  actions.close(prompt_bufnr)
  vim.cmd(string.format("edit %s/%s.lua", config.options.path, new_scratch))
end

function M.open(opts)
  opts = opts or {}
  require("telescope.builtin").find_files(vim.tbl_extend('force', {
    prompt_title = "Scratchs",
    no_ignore = true,
    cwd = config.options.path,
    attach_mappings = function(_, map)
      map("i", config.options.new_scratch_map, M.new)

      return true
    end,
  }, opts))
end

M.save_and_exec = function()
  local current_file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")

  vim.api.nvim_command "silent w"
  vim.api.nvim_command "so"

  vim.notify(string.format("File %s Sourced", current_file_name), vim.log.levels.INFO, { title = "Scratch" })
end

return M
