
--      ████████╗ ██████╗ ██████╗     ██████╗  █████╗ ███╗   ██╗███████╗██╗
--      ╚══██╔══╝██╔═══██╗██╔══██╗    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--         ██║   ██║   ██║██████╔╝    ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--         ██║   ██║   ██║██╔═══╝     ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--         ██║   ╚██████╔╝██║         ██║     ██║  ██║██║ ╚████║███████╗███████╗
--         ╚═╝    ╚═════╝ ╚═╝         ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi

-- import widgets
local task_list = require("widgets.task-list")

-- define module table
local top_panel = {}

local volume_widget = require('awesome-wm-widgets.volume-widget.volume')

-- ===================================================================
-- Bar Creation
-- ===================================================================


top_panel.create = function(s)

   local panel = awful.wibar({
      screen = s,
      position = "bottom",
      ontop = true,
      height = beautiful.top_panel_height,
      width = s.geometry.width - 100,
   })

   panel:setup {
      expand = "none",
      task_list.create(s),
      layout = wibox.layout.align.horizontal,
      require("widgets.calendar").create(s),
      {
         layout = wibox.layout.fixed.horizontal,
         -- wibox.layout.margin(wibox.widget.systray(), dpi(5), dpi(5), dpi(5), dpi(5)),
         -- require("widgets.bluetooth"),
         -- require("widgets.network")(),
         -- require("widgets.battery"),
         volume_widget {widget_type = 'vertical_bar', device = 'default', main_color = '#ffffff10'}
         -- wibox.layout.margin(require("widgets.layout-box"), dpi(2), dpi(2), dpi(2), dpi(2))
      },
   }


   -- ===================================================================
   -- Functionality
   -- ===================================================================


   -- hide panel when client is fullscreen
   local function change_panel_visibility(client)
      if client.screen == s then
         panel.ontop = not client.fullscreen
      end
   end

   -- connect panel visibility function to relevant signals
   client.connect_signal("property::fullscreen", change_panel_visibility)
   client.connect_signal("focus", change_panel_visibility)

end

return top_panel
