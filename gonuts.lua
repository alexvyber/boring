local awful = require("awful")

local apps_to_start = {
  "chromium-browser",
  "google-chrome",
  "telegram-desktop",
  "discord",
  "telegram",
  "dolphin",
  "firefox",
  -- "qbittorrent",
  -- "vivaldi",
  -- "brave-browser",
  -- "google-chrome-beta",
  -- "mullvad",
  -- "blueman-manager",
}

function start_apps(apps_to_start)
  for _, app in ipairs(apps_to_start) do
    awful.spawn.single_instance(app, awful.rules.rules)
  end
end

return start_apps(apps_to_start)
