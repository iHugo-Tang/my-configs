local settings = require("settings")
local colors = require("colors")
local app_icons = require("helpers.app_icons")

local slack = sbar.add("item", "slack", {
  position = "right",
  icon = {
    font = "sketchybar-app-font:Regular:16.0",
  },
  label = { font = { family = settings.font.numbers } },
  update_freq = 3,
})

sbar.add("bracket", "slack.bracket", { slack.name }, {
  background = { color = colors.bg1 }
})

sbar.add("item", "slack.padding", {
  position = "right",
  width = settings.group_paddings
})

slack:subscribe("mouse.clicked", function(env)
  sbar.exec("open -a 'Slack.app'")
end)

slack:subscribe({"forced", "routine", "system_woke"}, function()
  local handle = io.popen('lsappinfo info -only StatusLabel "Slack"')
  local label_value = "•"
  if handle ~= nil then
    local result = handle:read("*a")
    label_value = result:match('"label"="(.-)"')
    handle:close()
  end

  -- 使用 Lua 的模式匹配提取 "label" 的值
  local color = colors.orange
  if label_value == "•" or label_value == "" or label_value == nil then
    color = colors.white
    label_value = "•"
  end
  slack:set({
    icon = {
      string = app_icons["Slack"],
      color = color,
    },
    label = {
      string = label_value,
      color = color,
    }
  })
end)

