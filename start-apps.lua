local awful = require("awful")

local apps_to_start = {
	"brave-browser",
	"vivaldi",
	"chromium-browser",
	"google-chrome",
	-- "firefox",
	"tg",
	"qbittorrent",
	"telegram-desktop",
	"Discord",
	"blueman-manager",
	"dolphin",
}

function start_apps(apps_to_start)
	for _, app in ipairs(apps_to_start) do
		awful.spawn.single_instance(app, awful.rules.rules)
	end
end

return start_apps(apps_to_start)
