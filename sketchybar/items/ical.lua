local settings = require("settings")
local colors = require("colors")
local app_icons = require("helpers.app_icons")

-- 定义解析函数
local function getEvents()
  local handle = io.popen('icalBuddy -ps "| @@@ | -- |" eventsToday')
  if (handle == nil) then
    return
  end
  local icalOutput = handle:read("*a")
  handle:close()

  local events = {}
  for title, time in icalOutput :gmatch("•%s(.-)@@@%s(%d+:%d+)") do
    table.insert(events, {time, title})
  end
  return events
end

local function isLessThan30MinutesFromNow(timeString)
  -- Get the current time
  local currentTime = os.date("*t")
  local currentHour = currentTime.hour
  local currentMinute = currentTime.min
  -- Parse the input time string
  local hour, minute = timeString:match("(%d+):(%d+)")
  hour = tonumber(hour)
  minute = tonumber(minute)
  -- Check if the parsed time is valid
  if not hour or not minute or hour < 0 or hour > 23 or minute < 0 or minute > 59 then
    return false, "Invalid time format"
  end
  -- Convert current time and input time to minutes since midnight
  local currentTotalMinutes = currentHour * 60 + currentMinute
  local inputTotalMinutes = hour * 60 + minute
  -- Calculate the difference in minutes
  local difference = inputTotalMinutes - currentTotalMinutes
  -- Adjust for times that are on the next day
  if difference < 0 then
    difference = difference + 24 * 60
  end
  -- Check if the difference is less than 30 minutes
  return difference < 30
end

local function anyEventLessThan30MinutesFromNow(events)
  for _, event in ipairs(events) do
    local timeString = event[1]
    if isLessThan30MinutesFromNow(timeString) then
      return true
    end
  end
  return false
end

local ical = sbar.add("item", "ical", {
  position = "right",
  icon = {
    font = "sketchybar-app-font:Regular:16.0",
  },
  label = { font = { family = settings.font.numbers } },
  update_freq = 10,
})

sbar.add("bracket", "ical.bracket", { ical.name }, {
  background = { color = colors.bg1 }
})

sbar.add("item", "ical.padding", {
  position = "right",
  width = settings.group_paddings
})

ical:subscribe("mouse.clicked", function(env)
  sbar.exec("open -a 'Calendar.app'")
end)

ical:subscribe({"forced", "routine", "system_woke"}, function()
  local events = getEvents()
  local label_value = "•"
  local eventsLen = #events

  -- 使用 Lua 的模式匹配提取 "label" 的值
  local color = colors.white
  if eventsLen > 0 then
    label_value = ''..eventsLen
  end
  if anyEventLessThan30MinutesFromNow(events) then
    color = colors.orange
  end
  ical:set({
    icon = {
      string = app_icons["Calendar"],
      color = color,
    },
    label = {
      string = label_value,
      color = color,
    }
  })
end)
