local awful = require("awful")

local apps_to_start = {
	"brave-browser",
	"vivaldi",
	"chromium-browser",
	"firefox",
	-- "microsoft-edge-dev",
	"tg",
	"qbittorrent",
	-- "nautilus",
	"blueman-manager",
	"dolphin",
}

function start_apps(apps_to_start)
	for _, app in ipairs(apps_to_start) do
		awful.spawn.single_instance(app, awful.rules.rules)
	end
end

return start_apps(apps_to_start)
