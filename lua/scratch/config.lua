local M = {}

---@class ScratchOptions
M.defaults = {
  path = vim.fn.stdpath('data') .. 'scratch/lua',
  new_scratch_map = '<c-y>',
  local_map = "<LocalLeader>x",
}

---@class ScratchOptions
M.options = {}

function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})
end

return M
