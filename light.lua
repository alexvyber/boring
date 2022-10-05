local awful = require("awful")
local gears = require("gears")

local isLeftPanel = require("user_configs")

local pastel = {}

local theme = require("theme")

-- ===================================================================
-- Pastel setup
-- ===================================================================

pastel.initialize = function()
	-- Import components
	require("components." .. theme .. ".wallpaper")
	require("components.exit-screen")
	require("components.volume-adjust")

	-- Import panels
	local left_panel = require("components." .. theme .. ".left-panel")
	local top_panel = require("components." .. theme .. ".top-panel")

	-- Set up each screen (add tags & panels)
	awful.screen.connect_for_each_screen(function(s)
		for i = 1, 18, 1 do
			awful.tag.add(i, {
				icon = gears.filesystem.get_configuration_dir() .. "/icons/tags/" .. theme .. "/" .. i .. ".png",
				icon_only = true,
				layout = awful.layout.suit.tile,
				screen = s,
				selected = i == 1,
			})
		end

		-- Only add the left panel on the primary screen
		if s.index == 1 then
			if isLeftPanel then
				left_panel.create(s)
			else
				-- nothing
			end
		end

		-- Add the top panel to every screen
		if isLeftPanel then
			top_panel.create(s)
		else
			-- nothing
		end
	end)
end

return pastel
