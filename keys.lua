local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Define mod keys
local modkey = "Mod4"
local altkey = "Mod1"

-- define module table
local keys = {}

-- -------------------------------------------------------------------
-- Movement Functions (Called by some keybinds)
-- -------------------------------------------------------------------

-- Move given client to given direction
local function move_client(c, direction)
  -- If client is floating, move to edge
  if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
    local workarea = awful.screen.focused().workarea
    if direction == "up" then
      c:geometry({ nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil })
    elseif direction == "down" then
      c:geometry({
        nil,
        y = workarea.height + workarea.y - c:geometry().height - beautiful.useless_gap * 2 - beautiful.border_width * 2,
        nil,
        nil,
      })
    elseif direction == "left" then
      c:geometry({ x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil })
    elseif direction == "right" then
      c:geometry({
        x = workarea.width + workarea.x - c:geometry().width - beautiful.useless_gap * 2 - beautiful.border_width * 2,
        nil,
        nil,
        nil,
      })
    end
  -- Otherwise swap the client in the tiled layout
  elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
    if direction == "up" or direction == "left" then
      awful.client.swap.byidx(-1, c)
    elseif direction == "down" or direction == "right" then
      awful.client.swap.byidx(1, c)
    end
  else
    awful.client.swap.bydirection(direction, c, nil)
  end
end

-- Resize client in given direction
local floating_resize_amount = dpi(20)
local tiling_resize_factor = 0.03

local function resize_client(c, direction)
  if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
    if direction == "up" then
      c:relative_move(0, 0, 0, -floating_resize_amount)
    elseif direction == "down" then
      c:relative_move(0, 0, 0, floating_resize_amount)
    elseif direction == "left" then
      c:relative_move(0, 0, -floating_resize_amount, 0)
    elseif direction == "right" then
      c:relative_move(0, 0, floating_resize_amount, 0)
    end
  else
    if direction == "up" then
      awful.client.incwfact(-tiling_resize_factor)
    elseif direction == "down" then
      awful.client.incwfact(tiling_resize_factor)
    elseif direction == "left" then
      awful.tag.incmwfact(-tiling_resize_factor)
    elseif direction == "right" then
      awful.tag.incmwfact(tiling_resize_factor)
    end
  end
end

-- raise focused client
local function raise_client()
  if client.focus then
    client.focus:raise()
  end
end

-- -------------------------------------------------------------------
-- Mouse bindings
-- -------------------------------------------------------------------

-- Mouse buttons on the desktop
keys.desktopbuttons = gears.table.join(
  -- left click on desktop to hide notification
  awful.button({}, 1, function()
    naughty.destroy_all_notifications()
  end)
)

-- Mouse buttons on the client
keys.clientbuttons = gears.table.join(
  -- Raise client
  awful.button({}, 1, function(c)
    client.focus = c
    c:raise()
  end),

  -- Move and Resize Client
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- -------------------------------------------------------------------
-- Desktop Key bindings
-- -------------------------------------------------------------------

keys.globalkeys = gears.table.join(

  -- Go to previous tag
  awful.key({ modkey }, "Tab", awful.tag.history.restore),

  -- + + + + + + + + + + + + + + + + + + + +
  -- SPAWN APPLICATION KEY BINDINGS
  -- + + + + + + + + + + + + + + + + + + + +

  -- Spawn terminal
  awful.key({ modkey }, "Return", function()
    awful.spawn(apps.terminal)
  end, { description = "open a terminal", group = "launcher" }),

  -- Spawn alternative terminal
  awful.key({ modkey, "Shift" }, "Return", function()
    awful.spawn(apps.altterminal)
  end, { description = "open a terminal", group = "launcher" }),

  -- launch rofi
  awful.key({ modkey }, "d", function()
    awful.spawn(apps.launcher)
  end, { description = "application launcher", group = "launcher" }),

  -- Spawn Nautilus
  awful.key({ modkey }, "Delete", function()
    awful.spawn(apps.filebrowser)
  end, { description = "open file browser", group = "launcher" }),

  -- Spawn Dolphin on its tag
  awful.key({ modkey, "Shift" }, "Delete", function()
    awful.spawn(apps.static_filebrowser)
  end, { description = "open file browser", group = "launcher" }),

  -- Spawn second alternative terminal
  awful.key({ modkey, "Control" }, "Return", function()
    awful.spawn(apps.code)
  end, { description = "open a terminal", group = "launcher" }),

  -- Spawn second alternative terminal
  awful.key({ modkey, "Mod1" }, "Return", function()
    awful.spawn(apps.onemoreterminal)
  end, { description = "open a terminal", group = "launcher" }),

  -- Spawn chrome
  --[[ awful.key({ modkey }, "Menu", function() ]]
  --[[   awful.spawn(apps.chrome) ]]
  --[[ end, { description = "open a terminal", group = "launcher" }), ]]

  -- + + + + + + + + + + + + + + + + + + + +
  -- FUNCTION KEYS
  -- + + + + + + + + + + + + + + + + + + + +

  -- Brightness
  -- awful.key({}, "XF86MonBrightnessUp", function()
  -- 	awful.spawn("xbacklight -inc 10", false)
  -- end, { description = "+10%", group = "hotkeys" }),

  -- awful.key({}, "XF86MonBrightnessDown", function()
  -- 	awful.spawn("xbacklight -dec 10", false)
  -- end, { description = "-10%", group = "hotkeys" }),

  -- ALSA volume control
  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.spawn("amixer set Master 5%+", false)
    awesome.emit_signal("volume_change")
  end, { description = "volume up", group = "hotkeys" }),

  awful.key({}, "XF86AudioLowerVolume", function()
    awful.spawn("amixer set Master 5%-", false)
    awesome.emit_signal("volume_change")
  end, { description = "volume down", group = "hotkeys" }),

  awful.key({}, "XF86AudioMute", function()
    awful.spawn("amixer -D pulse set Master 1+ toggle", false)
    awesome.emit_signal("volume_change")
  end, { description = "toggle mute", group = "hotkeys" }),

  awful.key({}, "XF86AudioNext", function()
    awful.spawn("mpc next", false)
  end, { description = "next music", group = "hotkeys" }),

  awful.key({}, "XF86AudioPrev", function()
    awful.spawn("mpc prev", false)
  end, { description = "previous music", group = "hotkeys" }),

  awful.key({}, "XF86AudioPlay", function()
    awful.spawn("mpc toggle", false)
  end, { description = "play/pause music", group = "hotkeys" }),

  -- Screenshot on prtscn using scrot
  awful.key({}, "Print", function()
    awful.util.spawn(apps.screenshot, false)
  end),

  -- Screenshot on prtscn using scrot with selecting area
  awful.key({ modkey }, "s", function()
    awful.util.spawn(apps.screenarea, false)
  end),

  -- Screenshot on prtscn using scrot
  -- select area and copy into clipboard
  awful.key({ modkey, "Shift" }, "s", function()
    awful.util.spawn(apps.screenbuffer, false)
  end),

  awful.key({ modkey, "Shift" }, "f", function()
    awful.util.spawn(apps.flameshot, false)
  end),

  awful.key({ modkey }, "o", function()
    awful.spawn("amixer set Master 50%-", false)
    awesome.emit_signal("volume_change")
  end),

  awful.key({ modkey }, "i", function()
    awful.spawn("amixer set Master 50%+", false)
    awesome.emit_signal("volume_change")
  end),
  -- + + + + + + + + + + + + + + + + + + + +
  -- RELOAD / QUIT AWESOME
  -- + + + + + + + + + + + + + + + + + + + +

  -- Reload Awesome
  awful.key({ modkey }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),

  -- + + + + + + + + + + + + + + + + + + + +
  -- CLIENT FOCUSING
  -- + + + + + + + + + + + + + + + + + + + +

  -- Focus client by direction (hjkl keys)
  awful.key({ modkey }, "j", function()
    awful.client.focus.bydirection("down")
    raise_client()
  end, { description = "focus down", group = "client" }),

  awful.key({ modkey }, "k", function()
    awful.client.focus.bydirection("up")
    raise_client()
  end, { description = "focus up", group = "client" }),

  -- go left
  awful.key({ modkey }, "h", function()
    awful.client.focus.bydirection("left")
    raise_client()
  end, { description = "focus left", group = "client" }),

  awful.key({ modkey }, "bracketleft", function()
    awful.client.focus.bydirection("left")
    raise_client()
  end),

  -- go right
  awful.key({ modkey }, "l", function()
    awful.client.focus.bydirection("right")
    raise_client()
  end, { description = "focus right", group = "client" }),

  awful.key({ modkey }, "bracketright", function()
    awful.client.focus.bydirection("right")
    raise_client()
  end),

  -- Focus client by direction (arrow keys)
  awful.key({ modkey }, "Down", function()
    awful.client.focus.bydirection("down")
    raise_client()
  end, { description = "focus down", group = "client" }),

  awful.key({ modkey }, "Up", function()
    awful.client.focus.bydirection("up")
    raise_client()
  end, { description = "focus up", group = "client" }),

  awful.key({ modkey }, "Left", function()
    awful.client.focus.bydirection("left")
    raise_client()
  end, { description = "focus left", group = "client" }),

  awful.key({ modkey }, "Right", function()
    awful.client.focus.bydirection("right")
    raise_client()
  end, { description = "focus right", group = "client" }),

  -- Focus client by index (cycle through clients)
  awful.key({ altkey }, "Tab", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),

  awful.key({ altkey, "Shift" }, "Tab", function()
    awful.client.focus.byidx(-2)
  end, { description = "focus previous by index", group = "client" }),

  -- + + + + + + + + + + + + + + + + + + + +
  -- SCREEN FOCUSING
  -- + + + + + + + + + + + + + + + + + + + +

  -- Focus screen by index (cycle through screens)
  -- awful.key({ modkey }, "s", function()
  -- 	awful.screen.focus_relative(1)
  -- end),

  -- + + + + + + + + + + + + + + + + + + + +
  -- CLIENT RESIZING
  -- + + + + + + + + + + + + + + + + + + + +

  awful.key({ modkey, "Control" }, "Down", function(c)
    resize_client(client.focus, "down")
  end),

  awful.key({ modkey, "Control" }, "Up", function(c)
    resize_client(client.focus, "up")
  end),

  awful.key({ modkey, "Control" }, "Left", function(c)
    resize_client(client.focus, "left")
  end),

  awful.key({ modkey, "Control" }, "Right", function(c)
    resize_client(client.focus, "right")
  end),

  awful.key({ modkey, "Control" }, "j", function(c)
    resize_client(client.focus, "down")
  end),

  awful.key({ modkey, "Control" }, "k", function(c)
    resize_client(client.focus, "up")
  end),

  awful.key({ modkey, "Control" }, "h", function(c)
    resize_client(client.focus, "left")
  end),

  awful.key({ modkey, "Control" }, "l", function(c)
    resize_client(client.focus, "right")
  end),

  awful.key({ modkey, "Control" }, "bracketleft", function(c)
    resize_client(client.focus, "left")
  end),

  awful.key({ modkey, "Control" }, "bracketright", function(c)
    resize_client(client.focus, "right")
  end),

  -- + + + + + + + + + + + + + + + + + + + +
  -- NUMBER OF MASTER / COLUMN CLIENTS
  -- + + + + + + + + + + + + + + + + + + + +

  -- Number of master clients
  awful.key({ modkey, altkey }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = "increase the number of master clients", group = "layout" }),

  awful.key({ modkey, altkey }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = "decrease the number of master clients", group = "layout" }),

  awful.key({ modkey, altkey }, "Left", function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = "increase the number of master clients", group = "layout" }),

  awful.key({ modkey, altkey }, "Right", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = "decrease the number of master clients", group = "layout" }),

  -- Number of columns
  awful.key({ modkey, altkey }, "k", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "increase the number of columns", group = "layout" }),

  awful.key({ modkey, altkey }, "j", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "decrease the number of columns", group = "layout" }),

  awful.key({ modkey, altkey }, "Up", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "increase the number of columns", group = "layout" }),

  awful.key({ modkey, altkey }, "Down", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "decrease the number of columns", group = "layout" }),

  -- + + + + + + + + + + + + + + + + + + + +
  -- GAP CONTROL
  -- + + + + + + + + + + + + + + + + + + + +

  -- Gap control
  awful.key({ modkey }, "apostrophe", function()
    awful.tag.incgap(3, nil)
  end, { description = "decrement gap size for the current tag", group = "gaps" }),

  awful.key({ modkey }, "backslash", function()
    awful.tag.incgap(-3, nil)
  end, { description = "increment gaps size for the current tag", group = "gaps" }),

  -- + + + + + + + + + + + + + + + + + + + +
  -- LAYOUT SELECTION
  -- + + + + + + + + + + + + + + + + + + + +

  -- select next layout
  awful.key({ modkey }, "space", function()
    awful.layout.inc(1)
  end, { description = "select next", group = "layout" }),

  -- select previous layout
  awful.key({ modkey, "Shift" }, "space", function()
    awful.layout.inc(-1)
  end, { description = "select previous", group = "layout" }),

  -- + + + + + + + + + + + + + + + + + + + +
  -- CLIENT MINIMIZATION
  -- + + + + + + + + + + + + + + + + + + + +

  -- restore minimized client
  awful.key({ modkey, "Shift" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      client.focus = c
      c:raise()
    end
  end, { description = "restore minimized", group = "client" })
)

-- -------------------------------------------------------------------
-- Client Key bindings
-- -------------------------------------------------------------------

keys.clientkeys = gears.table.join(

  -- stick window
  awful.key({ modkey }, "b", function(c)
    c.sticky = not c.sticky
  end),

  -- Move to edge or swap by direction
  awful.key({ modkey, "Shift" }, "Down", function(c)
    move_client(c, "down")
  end),

  awful.key({ modkey, "Shift" }, "Up", function(c)
    move_client(c, "up")
  end),

  -- Move client left
  awful.key({ modkey, "Shift" }, "Left", function(c)
    move_client(c, "left")
  end),

  awful.key({ modkey, "Shift" }, "bracketleft", function(c)
    move_client(c, "left")
  end),

  -- Move client right
  awful.key({ modkey, "Shift" }, "Right", function(c)
    move_client(c, "right")
  end),

  awful.key({ modkey, "Shift" }, "bracketright", function(c)
    move_client(c, "right")
  end),

  awful.key({ modkey, "Shift" }, "j", function(c)
    move_client(c, "down")
  end),

  awful.key({ modkey, "Shift" }, "k", function(c)
    move_client(c, "up")
  end),

  awful.key({ modkey, "Shift" }, "h", function(c)
    move_client(c, "left")
  end),

  awful.key({ modkey, "Shift" }, "l", function(c)
    move_client(c, "right")
  end),

  -- toggle fullscreen
  awful.key({ modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
  end, { description = "toggle fullscreen", group = "client" }),

  -- close client
  awful.key({ modkey }, "q", function(c)
    c:kill()
  end, { description = "close", group = "client" }),

  -- Minimize
  awful.key({ modkey }, "n", function(c)
    c.minimized = true
  end, { description = "minimize", group = "client" }),

  -- Maximize
  awful.key({ modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, { description = "(un)maximize", group = "client" })
)

-- Bind all key numbers to tags
for i = 1, 6 do
  keys.globalkeys = gears.table.join(
    keys.globalkeys,

    -- Switch to tag
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i + 1]
      if tag then
        tag:view_only()
      end
    end, { description = "view tag #" .. i, group = "tag" }),

    -- Move client to tag
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i + 1]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, { description = "move focused client to tag #" .. i, group = "tag" })
  )
end

-- Bind all key numbers to tags
for i = 7, 13 do
  keys.globalkeys = gears.table.join(
    keys.globalkeys,

    -- Switch to tag
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i + 1]
      if tag then
        tag:view_only()
      end
    end, { description = "view tag #" .. i, group = "tag" }),

    -- Move client to tag
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i + 1]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, { description = "move focused client to tag #" .. i, group = "tag" })
  )
end

-- Postgres Tag
keys.globalkeys = gears.table.join(
  keys.globalkeys,

  -- Switch to tag
  awful.key({ modkey }, "#" .. 55, function()
    local screen = awful.screen.focused()
    local tag = screen.tags[7]
    if tag then
      tag:view_only()
    end
  end, { description = "view tag #" .. 7, group = "tag" }),

  -- Move client to tag
  awful.key({ modkey, "Shift" }, "#" .. 55, function()
    if client.focus then
      local tag = client.focus.screen.tags[7]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end, { description = "move focused client to tag #" .. 7, group = "tag" })
)

-- OBS Tag
keys.globalkeys = gears.table.join(
  keys.globalkeys,

  -- Switch to tag
  awful.key({ modkey }, "#" .. 54, function()
    local screen = awful.screen.focused()
    local tag = screen.tags[8]
    if tag then
      tag:view_only()
    end
  end, { description = "view tag #" .. 8, group = "tag" }),

  -- Move client to tag
  awful.key({ modkey, "Shift" }, "#" .. 54, function()
    if client.focus then
      local tag = client.focus.screen.tags[8]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end, { description = "move focused client to tag #" .. 8, group = "tag" })
)

-- keys.globalkeys = gears.table.join(
--   keys.globalkeys, -- View tag only.
--   awful.key({ modkey }, "#" .. 25, function()
--     local screen = awful.screen.focused()
--     local tag = screen.tags[10]
--     if tag then
--       tag:view_only()
--     end
--   end, { description = "view tag #" .. 15, group = "tag" }),

--   -- Move client to tag
--   awful.key({ modkey, "Shift" }, "#" .. 25, function()
--     if client.focus then
--       local tag = client.focus.screen.tags[10]
--       if tag then
--         client.focus:move_to_tag(tag)
--       end
--     end
--   end, { description = "move focused client to tag #" .. 1, group = "tag" })
-- )

keys.globalkeys = gears.table.join(
  keys.globalkeys, -- View tag only.
  awful.key({ modkey }, "#" .. 9, function()
    local screen = awful.screen.focused()
    local tag = screen.tags[12]
    if tag then
      tag:view_only()
    end
  end, { description = "view tag #" .. 15, group = "tag" }),

  -- Move client to tag
  awful.key({ modkey, "Shift" }, "#" .. 9, function()
    if client.focus then
      local tag = client.focus.screen.tags[12]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end, { description = "move focused client to tag #" .. 1, group = "tag" })
)

keys.globalkeys = gears.table.join(
  keys.globalkeys, -- View tag only.
  awful.key({ modkey }, "#" .. 49, function()
    local screen = awful.screen.focused()
    local tag = screen.tags[1]
    if tag then
      tag:view_only()
    end
  end, { description = "view tag #" .. 14, group = "tag" }),

  -- Move client to tag
  awful.key({ modkey, "Shift" }, "#" .. 49, function()
    if client.focus then
      local tag = client.focus.screen.tags[1]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end, { description = "move focused client to tag #" .. 1, group = "tag" })
)

-- Telegram
keys.globalkeys = gears.table.join(
  keys.globalkeys, -- View tag only.
  awful.key({ modkey }, "#" .. 118, function()
    local screen = awful.screen.focused()
    local tag = screen.tags[12]
    if tag then
      tag:view_only()
    end
  end, { description = "view tag #" .. 12, group = "tag" }),

  -- Move client to tag
  awful.key({ modkey, "Shift" }, "#" .. 118, function()
    if client.focus then
      local tag = client.focus.screen.tags[12]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end, { description = "move focused client to tag #" .. 12, group = "tag" })
)

-- Kitty Terminal
keys.globalkeys = gears.table.join(
  keys.globalkeys, -- View tag only.
  awful.key({ modkey }, "#" .. 66, function()
    local screen = awful.screen.focused()
    local tag = screen.tags[9]
    if tag then
      tag:view_only()
    end
  end, { description = "view tag #" .. 9, group = "tag" }),

  -- Move client to tag
  awful.key({ modkey, "Shift" }, "#" .. 66, function()
    if client.focus then
      local tag = client.focus.screen.tags[9]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end, { description = "move focused client to tag #" .. 9, group = "tag" })
)

-- Node
keys.globalkeys = gears.table.join(
  keys.globalkeys, -- View tag only.
  awful.key({ modkey }, "#" .. 25, function()
    local screen = awful.screen.focused()
    local tag = screen.tags[18]
    if tag then
      tag:view_only()
    end
  end, { description = "view tag #" .. 18, group = "tag" }),
  -- Move client to tag
  awful.key({ modkey, "Shift" }, "#" .. 25, function()
    if client.focus then
      local tag = client.focus.screen.tags[18]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end, { description = "move focused client to tag #" .. 18, group = "tag" })
)

-- Google Chrome
keys.globalkeys = gears.table.join(
  keys.globalkeys, -- View tag only.
  awful.key({ modkey }, "#" .. 67, function()
    local screen = awful.screen.focused()
    local tag = screen.tags[16]
    if tag then
      tag:view_only()
    end
  end, { description = "view tag #" .. 17, group = "tag" }),
  -- Move client to tag
  awful.key({ modkey, "Shift" }, "#" .. 67, function()
    if client.focus then
      local tag = client.focus.screen.tags[16]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end, { description = "move focused client to tag #" .. 16, group = "tag" })
)

keys.globalkeys = gears.table.join(
  keys.globalkeys, -- View tag only.
  awful.key({ modkey }, "#" .. 26, function()
    local screen = awful.screen.focused()
    local tag = screen.tags[15]
    if tag then
      tag:view_only()
    end
  end, { description = "view tag #" .. 14, group = "tag" }),

  -- Move client to tag
  awful.key({ modkey, "Shift" }, "#" .. 26, function()
    if client.focus then
      local tag = client.focus.screen.tags[15]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end, { description = "move focused client to tag #" .. 1, group = "tag" })
)

keys.globalkeys = gears.table.join(
  keys.globalkeys, -- View tag only.
  awful.key({ modkey }, "p", function()
    local screen = awful.screen.focused()
    local tag = screen.tags[7]
    if tag then
      tag:view_only()
    end
  end, { description = "view tag #" .. 14, group = "tag" }),

  -- Move client to tag
  awful.key({ modkey, "Shift" }, "p", function()
    if client.focus then
      local tag = client.focus.screen.tags[7]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end, { description = "move focused client to tag #" .. 1, group = "tag" })
)

keys.globalkeys = gears.table.join(
  keys.globalkeys, -- View tag only.
  awful.key({ modkey }, "a", function()
    local screen = awful.screen.focused()
    local tag = screen.tags[9]
    if tag then
      tag:view_only()
    end
  end, { description = "a", group = "tag" }),

  -- Move client to tag
  awful.key({ modkey, "Shift" }, "a", function()
    if client.focus then
      local tag = client.focus.screen.tags[9]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end, { description = "move focused client to tag #" .. 1, group = "tag" })
)

return keys
