local M = {}

M.copilot = {
  suggestion = {
    keymap = {
      accept = "<M-j>",
    },
  }
}

M.copilot_cmp = {
  sources = {
    { name = "nvim_lsp", group_index = 2 },
    { name = "copilot",  group_index = 2 },
    { name = "luasnip",  group_index = 2 },
    { name = "buffer",   group_index = 2 },
    { name = "nvim_lua", group_index = 2 },
    { name = "path",     group_index = 2 },
  },
}

return M
