local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Galaxy'
config.font = wezterm.font '0xProto Nerd Font Mono'
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'NONE'
return config
