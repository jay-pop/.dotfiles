local wezterm = require("wezterm")

if wezterm.config_builder then
	config = wezterm.config_builder()
end
-- config.color_scheme = "Gigavolt (base16)"
--config.color_scheme = "Github"
--config.color_scheme = "Github (Gogh)"
--config.color_scheme = "DanQing Light (base16)"
--config.color_scheme = "Dark Violet (base16)"
--config.color_scheme = "darkmatrix"
--config.color_scheme = "darkermatrix"
--config.color_scheme = "dawnfox"
-- config.color_scheme = "Gruvbox dark, pale (base16)"
-- config.color_scheme = "Gruvbox dark, soft (base16)"
-- config.color_scheme = 'Gruvbox dark, medium (base16)'
-- config.color_scheme = "Operator Mono Dark"
-- config.color_scheme = "OneHalfDark"

config.window_decorations = "None"
config.enable_tab_bar = false
config.custom_block_glyphs = true
config.scrollback_lines = 100000

-- config.color_scheme = "rose-pine"
-- config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Marrakesh (dark) (terminal.sexy)"
-- config.color_scheme = "Nord (base16)"
--config.window_background_opacity = 0.91
-- config.font_size = 17

-- config.color_scheme = "Mono Theme (terminal.sexy)"
-- config.color_scheme = "Gotham (terminal.sexy)"
-- config.color_scheme = "Grayscale (dark) (terminal.sexy)"
-- config.window_background_opacity = 0.9
config.font_size = 17

config.font = wezterm.font("BerkeleyMono Nerd Font Mono")
--config.font = wezterm.font("BerkeleyMono Nerd Font Mono", { italic = false })

config.line_height = 1

config.window_close_confirmation = "NeverPrompt"
config.default_prog = { "/bin/zsh", "-c", "~/personal/.dotfiles/.local/bin/tmux-launcher" }

-- Set background to same color as neovim
--config.colors = {}
--config.colors.background = "#111111"

-- required for nvim zen mode
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				overrides.window_background_opacity = config.window_background_opacity
				number_value = number_value - 1
			end
		elseif number_value < 0 then
			overrides.window_background_opacity = config.window_background_opacity
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
		else
			overrides.window_background_opacity = 1
			overrides.font_size = number_value
		end
	end
	window:set_config_overrides(overrides)
end)

config.window_padding = {
	left = "0.5%",
	right = "0.5%",
	top = "0.5%",
	bottom = "0.5%",
}

local act = wezterm.action

config.keys = {
	-- Create a new tab in the same domain as the current pane.
	-- This is usually what you want.
	{
		key = "t",
		mods = "SHIFT|ALT",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	-- Create a new tab in the default domain
	{ key = "t", mods = "SHIFT|ALT", action = act.SpawnTab("DefaultDomain") },
	-- Create a tab in a named domain
	{
		key = "t",
		mods = "SHIFT|ALT",
		action = act.SpawnTab({
			DomainName = "unix",
		}),
	},
}

config.keys = {
	{ key = "n", mods = "SHIFT|CTRL", action = wezterm.action.SpawnWindow },
}

color_scheme = "Custom Color Scheme"

config.colors = {
	-- Default colors
	foreground = "#ECE1D7",
	background = "#292522",
	cursor_bg = "#ECE1D7",
	cursor_fg = "#292522",
	cursor_border = "#ECE1D7",
	selection_fg = "#292522",
	selection_bg = "#ECE1D7",

	-- Normal colors
	ansi = { "#34302C", "#BD8183", "#78997A", "#E49B5D", "#7F91B2", "#B380B0", "#7B9695", "#C1A78E" },
	brights = { "#867462", "#D47766", "#85B695", "#EBC06D", "#A3A9CE", "#CF9BC2", "#89B3B6", "#ECE1D7" },

	-- Indexed colors
	indexed = {
		[16] = "#867462",
		[17] = "#D47766",
		[18] = "#85B695",
		[19] = "#EBC06D",
		[20] = "#A3A9CE",
		[21] = "#CF9BC2",
		[22] = "#89B3B6",
		[23] = "#ECE1D7",
	},
}

-- config.colors = {
-- 	background = "#292522",
-- 	foreground = "#ECE1D7",
-- }

return config
