local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Galaxy'
config.font = wezterm.font '0xProto Nerd Font Mono'

return config
