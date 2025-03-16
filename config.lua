CONFIG_API.CONFIG = {
	enabled = true,
	toggle = true,
	slider = 50,
	input = "TEXT",
	option = "2",
	tab = {
		label = "Some Label",
	},
	nested_tabs = {
		tab1 = {
			tab1 = {
				toggle = true,
			},
			tab2 = {
				toggle = false,
			},
		},
		tab2 = {
			tab1 = {
				toggle = true,
			},
			tab2 = {
				toggle = false,
			},
		},
	},
}

---@type ConfigGroup
CONFIG_API.CONFIG_UI = {
	label = "Input Types",
	toggle = {
		type = "toggle",
		order = 1,
	},
	slider = {
		type = "slider",
		w = 3,
		min = 0,
		max = 100,
		order = 4,
	},
	option = {
		order = 3,
		type = "option",
		options = {
			"1",
			"2",
			"3",
		},
	},
	---@type ConfigGroup
	tab = {
		order = 1,
		config_api_label = "Config Tab",
		custom = {
			order = 2,
			type = "custom",
			build = function()
				return {
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = { -- Example node:
						{
							n = G.UIT.C,
							config = { align = "cm", padding = 0.1, colour = G.C.BLUE, r = 0.5 },
							nodes = {
								{
									n = G.UIT.T,
									config = { text = "Hello, world!", colour = G.C.UI.TEXT_LIGHT, scale = 0.5 },
								},
							},
						},
					},
				}
			end,
		},
	},
	---@type ConfigGroup
	nested_tabs = {
		order = 2,
		config_api_label = "Nested Tabs",
		---@type ConfigGroup
		tab1 = {
			config_api_label = "Tab 1",
			---@type ConfigGroup
			tab1 = {
				config_api_label = "Tab 1, 1",
				toggle = {
					type = "toggle",
				},
			},
			---@type ConfigGroup
			tab2 = {
				config_api_label = "Tab 1, 2",
				toggle = {
					type = "toggle",
				},
			},
		},
		---@type ConfigGroup
		tab2 = {
			config_api_label = "Tab 2",
			---@type ConfigGroup
			tab1 = {
				config_api_label = "Tab 2, 1",
				toggle = {
					type = "toggle",
				},
			},
			---@type ConfigGroup
			tab2 = {
				config_api_label = "Tab 2, 2",
				toggle = {
					type = "toggle",
				},
			},
		},
	},
}

return CONFIG_API.CONFIG
