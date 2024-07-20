local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- define module table
local theme = {}

-- -------------------------------------------------------------------
-- Theme Variables
-- -------------------------------------------------------------------

theme.name = "pastel"

-- Font
theme.font = "JetBrains Mono Medium 10"
theme.title_font = "JetBrains Mono Bold 10"

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
theme.border_width = dpi(0)
theme.border_normal = "#e9e9e9"
theme.border_focus = "#e9e9e9"
theme.border_marked = "#e9e9e9"

-- Taglist
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_occupied = "#00000012"
theme.taglist_bg_focus = "#00000024"
theme.taglist_bg_urgent = "#00000040"

-- Tasklist
theme.tasklist_font = "#ffffff90"
theme.tasklist_bg_normal = "#ffffff14"
theme.tasklist_bg_focus = "#ffffff40"
theme.tasklist_bg_urgent = "#ffffff"

theme.tasklist_fg_focus = "#444444"
theme.tasklist_fg_urgent = "#444444"
theme.tasklist_fg_normal = "#444444"

-- Panel Sizing
theme.left_panel_width = dpi(42)
theme.top_panel_height = dpi(20)

-- Notification Sizing
theme.notification_max_width = dpi(450)

-- System Tray
theme.bg_systray = "#cccccc"
theme.systray_icon_spacing = dpi(20)

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
