---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'chadracula',
  theme_toggle = { "chadracula", "one_light" },
  hl_override = {
    NeogitDiffDeleteHighlight = { fg = "#ff6c6b", bg = "#3d3d3d" },
  },
  hl_add = {
    NeogitDiffDeleteHighlight = { fg = "#ff6c6b", bg = "#3d3d3d" },
  },
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
