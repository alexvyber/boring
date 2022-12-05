local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- define module table
local theme = {}

-- -------------------------------------------------------------------
-- Theme Variables
-- -------------------------------------------------------------------

theme.name = "pastel"

-- Font
theme.font = "Work Sans Medium 10"
theme.title_font = "Work Sans Bold 12"

-- Background
theme.bg_normal = "#ffffff00"
theme.bg_dark = "#000000"
theme.bg_focus = "#ffffff"
theme.bg_urgent = "#858585"
theme.bg_minimize = "#bcbcbc"

-- Foreground
theme.fg_normal = "#ffffff"
theme.fg_focus = "#000000"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#444444"

-- Window Gap Distance
theme.useless_gap = dpi(2)

-- Show Gaps if Only One Client is Visible
theme.gap_single_client = true

-- Window Borders
theme.border_width = dpi(2)
theme.border_normal = "#eeeeee"
theme.border_focus = "#ff0000"
theme.border_marked = "#0000ff"

-- Taglist
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_occupied = "#00000014"
theme.taglist_bg_urgent = "#00000032"
theme.taglist_bg_focus = theme.bg_focus

-- Tasklist
theme.tasklist_font = theme.font
theme.tasklist_bg_normal = "#00000022"
theme.tasklist_bg_focus = "#ffffff"
theme.tasklist_bg_urgent = theme.bg_urgent

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_fg_normal = "#444444"

-- Panel Sizing
theme.left_panel_width = dpi(55)
theme.top_panel_height = dpi(25)

-- Notification Sizing
theme.notification_max_width = dpi(350)

-- System Tray
theme.bg_systray = theme.bg_normal
theme.systray_icon_spacing = dpi(23)

-- Titlebars
theme.titlebars_enabled = false

-- -------------------------------------------------------------------
-- Icons
-- -------------------------------------------------------------------

-- Define layout icons
theme.layout_tile = "~/.config/awesome/icons/layouts/tiled.png"
theme.layout_floating = "~/.config/awesome/icons/layouts/floating.png"
theme.layout_max = "~/.config/awesome/icons/layouts/maximized.png"

theme.icon_theme = "Tela-dark"

-- return theme
return theme
