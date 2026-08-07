local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.exit_behavior = "Close"

-- ======================================================
-- Performance
-- ======================================================

config.front_end = "OpenGL"
config.max_fps = 60
config.animation_fps = 60
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 200
config.term = "xterm-256color"

-- ======================================================
-- Font
-- ======================================================

config.font = wezterm.font_with_fallback({
	"ComicShannsMono Nerd Font Mono",
	"ComicShannsMono Nerd Font",
	"Consolas",
})

config.font_size = 11

-- ======================================================
-- Window
-- ======================================================

config.window_background_opacity = 9.0
config.text_background_opacity = 1.0

config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}

config.initial_cols = 130
config.initial_rows = 35

config.hide_mouse_cursor_when_typing = true
config.adjust_window_size_when_changing_font_size = false

config.enable_tab_bar = true
config.use_fancy_tab_bar = true

config.window_frame = {
	active_titlebar_bg = "#74665A",
	inactive_titlebar_bg = "#62564D",
}

config.window_decorations = "RESIZE"

-- ======================================================
-- Colors
-- ======================================================

local bg = "#55504B"
local current = "#645F5A"
local fg = "#F0E6DC"
local accent = "#E6D2B4"
local accent2 = "#D2BEA0"
local selection = "#8C8278"
local comment = "#A0968C"
local gold = "#D4AF37"

config.colors = {
	foreground = fg,
	background = bg,

	cursor_bg = accent,
	cursor_fg = bg,
	cursor_border = accent,
	compose_cursor = accent,

	selection_fg = fg,
	selection_bg = selection,

	scrollbar_thumb = comment,
	split = comment,

	ansi = {
		bg,
		"#BE8282",
		"#C8B496",
		accent,
		accent2,
		"#D6C0A8",
		"#DDD0C3",
		fg,
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
		[136] = gold,
	},

	copy_mode_active_highlight_bg = {
		Color = selection,
	},

	copy_mode_active_highlight_fg = {
		Color = fg,
	},

	copy_mode_inactive_highlight_bg = {
		Color = current,
	},

	copy_mode_inactive_highlight_fg = {
		Color = fg,
	},

	quick_select_label_bg = {
		Color = accent,
	},

	quick_select_label_fg = {
		Color = bg,
	},

	quick_select_match_bg = {
		Color = selection,
	},

	quick_select_match_fg = {
		Color = fg,
	},
}

-- ======================================================
-- Cross Platform Helpers
-- ======================================================

local is_windows = wezterm.target_triple:find("windows") ~= nil

local function exe(name)
	if is_windows then
		return name .. ".exe"
	end
	return name
end

-- ======================================================
-- Events
-- ======================================================

wezterm.on("toggle-window-decoration", function(window)
	local overrides = window:get_config_overrides() or {}

	if overrides.window_decorations == "RESIZE" then
		overrides.window_decorations = "TITLE | RESIZE"
	else
		overrides.window_decorations = "RESIZE"
	end

	window:set_config_overrides(overrides)
end)

-- ======================================================
-- Keybinds
-- ======================================================

config.disable_default_key_bindings = true

config.keys = {

	------------------------------------------------------
	-- Window
	------------------------------------------------------

	{
		key = "T",
		mods = "ALT",
		action = act.EmitEvent("toggle-window-decoration"),
	},

    {
        key = "PageUp",
        mods = "CTRL|ALT",
        action = act.ActivateTabRelative(1),  -- Move to the next tab
    },


    {
        key = "PageDown",
        mods = "CTRL|ALT",
        action = act.ActivateTabRelative(-1), -- Move to the previous tab
    },

   -- Increase font size with CTRL + +
    {
        key = "=",
        mods = "CTRL",
        action = act.IncreaseFontSize,
    },

    -- Decrease font size with CTRL + -
    {
        key = "-",
        mods = "CTRL",
        action = act.DecreaseFontSize,
    },

    -- Reset font size with CTRL + 0

    {
        key = "0",
        mods = "CTRL",
        action = act.ResetFontSize,
    },

    {
        key = "N",
        mods = "ALT",
        action = act.SpawnTab("CurrentPaneDomain"),
    },

	------------------------------------------------------
	-- Opacity
	------------------------------------------------------

	{
		key = "O",
		mods = "ALT",
		action = wezterm.action_callback(function(window)
			local overrides = window:get_config_overrides() or {}

			local opacity =
				overrides.window_background_opacity
				or config.window_background_opacity

			opacity = math.max(opacity - 0.05, 0.35)

			overrides.window_background_opacity = opacity
			window:set_config_overrides(overrides)
		end),
	},

	{
		key = "P",
		mods = "ALT",
		action = wezterm.action_callback(function(window)
			local overrides = window:get_config_overrides() or {}

			local opacity =
				overrides.window_background_opacity
				or config.window_background_opacity

			opacity = math.min(opacity + 0.05, 1.0)

			overrides.window_background_opacity = opacity
			window:set_config_overrides(overrides)
		end),
	},

	------------------------------------------------------
	-- Splits
	------------------------------------------------------

	{
		key = "V",
		mods = "CTRL|ALT",
		action = act.SplitPane({
			direction = "Right",
			size = {
				Percent = 50,
			},
		}),
	},

	{
		key = "H",
		mods = "CTRL|ALT",
		action = act.SplitPane({
			direction = "Down",
			size = {
				Percent = 50,
			},
		}),
	},

	------------------------------------------------------
	-- Resize Panes
	------------------------------------------------------

	{
		key = "LeftArrow",
		mods = "ALT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},

	{
		key = "DownArrow",
		mods = "ALT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},

	{
		key = "UpArrow",
		mods = "ALT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},

	{
		key = "RightArrow",
		mods = "ALT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},

	------------------------------------------------------
	-- Pane Switch
	------------------------------------------------------

	{
		key = "\\",
		mods = "ALT",
		action = act.PaneSelect,
	},

	------------------------------------------------------
	-- Close Pane
	------------------------------------------------------

	{
		key = "Backspace",
		mods = "ALT",
		action = act.CloseCurrentPane({
			confirm = false,
		}),
	},

	------------------------------------------------------
	-- Debug
	------------------------------------------------------

	{
		key = "L",
		mods = "ALT",
		action = act.ShowDebugOverlay,
	},

	------------------------------------------------------
	-- Workflow Macros
	------------------------------------------------------

	{
		key = "E",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(_, pane)
			pane:send_text(exe("fresh") .. "\r")
		end),
	},

	{
		key = "F",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(_, pane)
			pane:send_text(exe("fzf") .. "\r")
		end),
	},

	{
		key = "B",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(_, pane)
			pane:send_text(exe("btop") .. "\r")
		end),
	},

	{
		key = "D",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(_, pane)
			pane:send_text(exe("lazydocker") .. "\r")
		end),
	},
}

-- ======================================================
-- Shell
-- ======================================================

if is_windows then
	config.default_prog = {
		"powershell.exe",
		"-NoLogo",
		"-NoExit",
		"-Command",
		[[fastfetch --config "$env:USERPROFILE\.config\fastfetch\config.jsonc" --logo-type file-raw --logo "$env:USERPROFILE\.config\fastfetch\logo.txt"]],
	}
else
	config.default_prog = {
		"fish",
	}
end

return config
