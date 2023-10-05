# Scratch.nvim

Plugin to work with lua scratch easily

Install

Lazy
```lua
{
  "adalessa/scratch.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  opts = {},
  keys = {
    {"<leader>rs", function()
      require('scratch').open()
    end},
  },
}
```

Default Options
```lua
{
  path = vim.fn.stdpath('data') .. '/scratch',
  new_scratch_map = '<c-y>',
  local_map = "<LocalLeader>x",
}
```

In the scratch buffers use the local map to triger the save an exec
