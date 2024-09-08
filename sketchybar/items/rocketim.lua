local settings = require("settings")
local colors = require("colors")
local app_icons = require("helpers.app_icons")

local rocket = sbar.add("item", "rocket", {
  position = "right",
  icon = { font = { family = settings.font.icon, } },
  label = { font = { family = settings.font.numbers } },
  update_freq = 3,
})

sbar.add("bracket", "rocket.bracket", { rocket.name }, {
  background = { color = colors.bg1 }
})

sbar.add("item", "rocket.padding", {
  position = "right",
  width = settings.group_paddings
})

rocket:subscribe("mouse.clicked", function(env)
  sbar.exec("open -a 'Rocket.Chat.app'")
end)

rocket:subscribe({"forced", "routine", "system_woke"}, function()
  local handle = io.popen('lsappinfo info -only StatusLabel "Rocket.Chat"')
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
  rocket:set({
    icon = {
      -- string = app_icons["Slack"],
      string = "",
      color = color,
    },
    label = {
      string = label_value,
      color = color,
    }
  })
end)
