CONFIG_API.MENU = {}

---@class Menu.Args
---@field back_func string
---@field nodes? UI.Node[]

---creates a config menu
---@param args Menu.Args
function CONFIG_API.create_menu(args)
	SMODS.LAST_SELECTED_MOD_TAB = "mod_desc"

	G.FUNCS.overlay_menu({
		definition = (create_UIBox_generic_options({
			back_func = args.back_func,
			contents = {
				{
					n = G.UIT.R,
					config = {
						padding = 0,
						align = "tm",
					},
					nodes = args.nodes or {},
				},
			},
		})),
	})
end
