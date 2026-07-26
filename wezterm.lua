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

-- === Colors ===
local mid_gold = "#ffcc00"
local light_gold = "#fff1b3"
local soft_gold = "#d4ad00"

config.colors = {
  foreground = soft_gold,
  background = "#fff9e6",

  cursor_bg = mid_gold,
  cursor_fg = "#000000",
  cursor_border = mid_gold,

  selection_fg = soft_gold,
  selection_bg = light_gold,

  scrollbar_thumb = mid_gold,
  split = mid_gold,

  ansi = {
    soft_gold,
    mid_gold,
    mid_gold,
    mid_gold,
    light_gold,
    light_gold,
    light_gold,
    "#ffffff",
  },

  brights = {
    soft_gold,
    mid_gold,
    mid_gold,
    mid_gold,
    light_gold,
    light_gold,
    light_gold,
    "#ffffff",
  },

  indexed = {
    [136] = mid_gold,
  },

  compose_cursor = mid_gold,

  copy_mode_active_highlight_bg = { Color = light_gold },
  copy_mode_active_highlight_fg = { Color = soft_gold },
  copy_mode_inactive_highlight_bg = { Color = light_gold },
  copy_mode_inactive_highlight_fg = { Color = soft_gold },

  quick_select_label_bg = { Color = mid_gold },
  quick_select_label_fg = { Color = soft_gold },
  quick_select_match_bg = { Color = light_gold },
  quick_select_match_fg = { Color = soft_gold },
}

-- === Tabs ===
config.enable_tab_bar = false
config.use_fancy_tab_bar = false

-- === Window Frame ===
config.window_frame = {
  active_titlebar_bg = mid_gold,
  inactive_titlebar_bg = "#d9a300",
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
