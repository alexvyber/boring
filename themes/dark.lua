
--      ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
--      ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
--         ██║   ███████║█████╗  ██╔████╔██║█████╗
--         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝
--         ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
--         ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- define module table
local theme = {}


-- ===================================================================
-- Theme Variables
-- ===================================================================


theme.name = "dark"

-- Font
theme.font = "Work Sans 10"
theme.title_font =  "Work Sans Medium 10"

-- Background
theme.bg_normal = "#00000000"
theme.bg_dark = "#000000"
theme.bg_focus = "#ffffff50"
theme.bg_urgent = "#f00"
theme.bg_minimize = "#101010"

-- Foreground
theme.fg_normal = "#ddd"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#bbb"

-- Window Gap Distance
theme.useless_gap = dpi(0)

-- Show Gaps if Only One Client is Visible
theme.gap_single_client = true

-- Window Borders
theme.border_width = dpi(0)
theme.border_normal = theme.bg_normal
theme.border_focus = "#ff8a65"
theme.border_marked = theme.fg_urgent

-- Taglist
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_occupied = "#ffffff14"
theme.taglist_bg_urgent =  "#aafaff36"
theme.taglist_bg_focus =  "#ffffff2f"

-- Tasklist
theme.tasklist_font = theme.font

theme.tasklist_bg_normal = "#ffffff18"
theme.tasklist_bg_focus =  "#ffffff1d"
theme.tasklist_bg_urgent = "ffffff24"

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_fg_normal = "#ffffffaa"

-- Panel Sizing
theme.left_panel_width = dpi(50)
theme.top_panel_height = dpi(25)

-- Notification Sizing
theme.notification_max_width = dpi(550)

-- System Tray
theme.bg_systray = theme.bg_normal
theme.systray_icon_spacing = dpi(23)

-- Titlebars
theme.titlebars_enabled = false


-- ===================================================================
-- Icons
-- ===================================================================

-- Define layout icons
theme.layout_tile = "~/.config/awesome/icons/layouts/tiled.png"
theme.layout_floating = "~/.config/awesome/icons/layouts/floating.png"
theme.layout_max = "~/.config/awesome/icons/layouts/maximized.png"

theme.icon_theme = "Tela-dark"

-- return theme
return theme
