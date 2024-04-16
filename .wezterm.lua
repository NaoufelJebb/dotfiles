local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action

-- Settings
config.font = wezterm.font("Source Code Pro")
config.font_size = 13.0
config.color_scheme = "Tokyo Night"
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

config.use_fancy_tab_bar = false
config.status_update_interval = 1000

return config
