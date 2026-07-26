local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.exit_behavior = "Close"

-- === Performance ===
config.front_end = "WebGpu"
config.max_fps = 60
config.animation_fps = 60
config.cursor_blink_rate = 5000
config.term = "xterm-256color"

-- === Font ===
config.font = wezterm.font_with_fallback({
  "ComicShannsMono Nerd Font Mono",
  "ComicShannsMono Nerd Font",
  "Consolas",
})
config.font_size = 10.0

-- === Appearance ===
config.window_background_opacity = 0.9
config.win32_system_backdrop = "Acrylic"

config.window_padding = {
  left = 6,
  right = 6,
  top = 6,
  bottom = 6,
}

config.hide_mouse_cursor_when_typing = true
config.adjust_window_size_when_changing_font_size = false

-- === Sepia Clay Palette ===
local bg = "#55504B"
local current = "#645F5A"
local fg = "#F0E6DC"
local accent = "#E6D2B4"
local accent2 = "#D2BEA0"
local selection = "#8C8278"
local comment = "#A0968C"

config.colors = {
  foreground = fg,
  background = bg,

  cursor_bg = accent,
  cursor_fg = bg,
  cursor_border = accent,

  selection_fg = fg,
  selection_bg = selection,

  scrollbar_thumb = comment,
  split = comment,

  ansi = {
    bg,         -- black
    "#BE8282",  -- red
    "#C8B496",  -- green
    accent,     -- yellow
    accent2,    -- blue
    "#D6C0A8",  -- magenta
    "#DDD0C3",  -- cyan
    fg,         -- white
  },

  brights = {
    current,
    "#D89A9A",
    "#DDD0B6",
    "#F2DEC0",
    "#E0CCB0",
    "#E0CCB0",
    "#F4ECE4",
    "#FFFFFF",
  },

  indexed = {
    [136] = accent2,
  },

  compose_cursor = accent,

  copy_mode_active_highlight_bg = { Color = selection },
  copy_mode_active_highlight_fg = { Color = fg },
  copy_mode_inactive_highlight_bg = { Color = current },
  copy_mode_inactive_highlight_fg = { Color = fg },

  quick_select_label_bg = { Color = accent },
  quick_select_label_fg = { Color = bg },
  quick_select_match_bg = { Color = selection },
  quick_select_match_fg = { Color = fg },
}

-- === Tabs ===
config.enable_tab_bar = false
config.use_fancy_tab_bar = false

-- === Window Frame ===
config.window_frame = {
  active_titlebar_bg = "#6E6761",
  inactive_titlebar_bg = "#5A544F",
}

-- === Window Decorations ===
config.window_decorations = "RESIZE"

wezterm.on("toggle-window-decoration", function(window, _)
  local overrides = window:get_config_overrides() or {}

  overrides.window_decorations =
    overrides.window_decorations == "RESIZE"
      and "TITLE | RESIZE"
      or "RESIZE"

  window:set_config_overrides(overrides)
end)

-- === Keybindings ===
config.keys = {
  {
    key = "T",
    mods = "CTRL|SHIFT",
    action = act.EmitEvent("toggle-window-decoration"),
  },

  {
    key = "h",
    mods = "CTRL|SHIFT|ALT",
    action = act.SplitPane({
      direction = "Right",
      size = { Percent = 50 },
    }),
  },

  {
    key = "v",
    mods = "CTRL|SHIFT|ALT",
    action = act.SplitPane({
      direction = "Up",
      size = { Percent = 50 },
    }),
  },

  {
    key = "U",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Left", 5 }),
  },

  {
    key = "I",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Down", 5 }),
  },

  {
    key = "O",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Up", 5 }),
  },

  {
    key = "P",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Right", 5 }),
  },

  {
    key = "9",
    mods = "CTRL",
    action = act.PaneSelect,
  },

  {
    key = "L",
    mods = "CTRL",
    action = act.ShowDebugOverlay,
  },

  {
    key = "O",
    mods = "CTRL|ALT",
    action = wezterm.action_callback(function(window, _)
      local overrides = window:get_config_overrides() or {}

      overrides.window_background_opacity =
        (overrides.window_background_opacity == 1.0)
          and 0.9
          or 1.0

      window:set_config_overrides(overrides)
    end),
  },
}

-- === Default Shell ===
config.default_prog = { "powershell.exe", "-NoLogo" }
config.initial_cols = 80

return config