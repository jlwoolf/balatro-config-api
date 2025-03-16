CONFIG_API.LAST_SELECTED_TAB = 1

---@class Tab.Args
---@field label string
---@field items? table<string, ConfigItem>
---@field tabs? table<string, ProcessedConfig>
---@field path? string
---@field ref_table? table

---@param i number
---@param args Tab.Args
---@return table
local function create_tab(i, args)
	return {
		label = args.label,
		chosen = CONFIG_API.LAST_SELECTED_TAB == i or false,
		tab_definition_function_args = args,
		tab_definition_function = function(config)
			CONFIG_API.LAST_SELECTED_TAB = i

			if #CONFIG_API.UTILS.keys(config.tabs or {}) > 0 then
				return CONFIG_API.BUILDER.build_menu(config, {
					path = config.path,
					ref_table = config.ref_table,
				}) or {}
			end

			return {
				n = G.UIT.ROOT,
				config = { align = "cm", padding = 0.05, colour = G.C.CLEAR },
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm", colour = G.C.CLEAR, r = 0.2 },
						nodes = CONFIG_API.BUILDER.build_items(config.items or {}, config.ref_table),
					},
				},
			}
		end,
	}
end

---@param tabs Tab.Args[]
---@return UI.Node|nil
function CONFIG_API.create_tabs(tabs)
	if #CONFIG_API.UTILS.keys(tabs) == 0 then
		return
	end

	local tab_nodes = {}
	for i, tab in ipairs(tabs) do
		table.insert(tab_nodes, create_tab(i, tab))
	end

	return create_tabs({
		snap_to_nav = true,
		colour = G.C.MULT,
		tab_alignment = "tm",
		tabs = tab_nodes,
	})
end
