local awful = require("awful")

local apps_to_start = {
	"qbittorrent",
	"deluge",
}

function start_apps(apps_to_start)
	for _, app in ipairs(apps_to_start) do
		awful.spawn.single_instance(app, awful.rules.rules)
	end
end

start_apps(apps_to_start)
