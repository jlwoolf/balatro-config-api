---@diagnostic disable: cast-type-mismatch
CONFIG_API.BUILDER = {}

---@class Custom.Args: table<string,any>
---@field build fun(args: Custom.Args): UI.Node[]

---@class Custom.WithType: Input.Args
---@field type 'custom'

---@class Custom.WithApiType: Input.Args
---@field config_api_type 'custom'

---@alias Custom Custom.WithType|Custom.WithApiType

---@alias ConfigItem Slider|Option|Toggle|Custom
---@alias ConfigGroup table<string, ConfigGroup | ConfigItem | string | number>

---@alias ProcessedConfig { items: table<string,ConfigItem>, tabs: table<string,ProcessedConfig>, label?: string, order?: number }

local ITEM_TYPES = {
	-- "input", -- input is disabled for now as it is buggy
	"slider",
	"option",
	"toggle",
	"custom",
}

local function is_item(item)
	if type(item) ~= "table" then
		return false
	end

	for _, v in pairs(ITEM_TYPES) do
		if item.config_api_type == v then
			return true
		end

		if item.type == v then
			return true
		end
	end

	return false
end

---@param item ConfigItem
local function get_item_type(item)
	return item.config_api_type or item.type
end

---@param config ConfigGroup
local function process_config(config)
	if type(config) ~= "table" then
		return nil
	end

	---@type ProcessedConfig
	local processed_config = {
		label = nil,
		items = {},
		tabs = {},
		order = 0,
	}
	for key, item in pairs(config) do
		if type(key) == "string" then
			if type(item) == "string" then
				if key == "config_api_label" or key == "label" then
					processed_config.label = item
				end
			elseif type(item) == "number" then
				if key == "config_api_order" or key == "order" then
					processed_config.order = item
				end
			elseif is_item(item) then
				processed_config.items[key] = item
			elseif type(item) == "table" then
				local sub_config = process_config(item)
				if sub_config then
					processed_config.tabs[key] = sub_config
				end
			end
		end
	end

	if #CONFIG_API.UTILS.keys(processed_config) == 0 then
		return nil
	end

	return processed_config
end

---@param item ConfigItem
function CONFIG_API.BUILDER.build_item(item)
	local item_type = get_item_type(item)

	if item_type == "input" then
		---@cast item Input.Args
		return CONFIG_API.create_input(item)
	elseif item_type == "slider" then
		---@cast item Slider.Args
		return CONFIG_API.create_slider(item)
	elseif item_type == "option" then
		---@cast item Option.Args
		return CONFIG_API.create_option(item)
	elseif item_type == "toggle" then
		---@cast item Toggle.Args
		return CONFIG_API.create_toggle(item)
	elseif item_type == "custom" then
		---@cast item Custom.Args
		return item.build(item)
	end
end

---@param items table<string, ConfigItem>
function CONFIG_API.BUILDER.build_items(items, ref_table)
	local nodes = {}

	CONFIG_API.UTILS.sort_by_order(items)
	for key, item in pairs(items) do
		item.ref_table = item.ref_table or ref_table
		item.ref_value = item.ref_value or key
		item.label = item.label or CONFIG_API.UTILS.format_key(key)
	end

	local items_arr = CONFIG_API.UTILS.to_array(items)
	CONFIG_API.UTILS.sort_by_order(items_arr)

	for _, item in ipairs(items_arr) do
		table.insert(nodes, CONFIG_API.BUILDER.build_item(item))
	end

	return nodes
end

CONFIG_API.TABS = {}

---@param config ProcessedConfig
---@param args? { path?: string, ref_table?: table, id?: string }
function CONFIG_API.BUILDER.build_menu(config, args)
	args = args or {}
	args.path = args.path or args.id or "config-api"

	---@type Tab.Args[]

	---@type Tab.Args[]
	local tabs = {}

	if #CONFIG_API.UTILS.keys(config.items) > 0 then
		table.insert(tabs, {
			label = config.label or "Default",
			items = config.items,
			ref_table = args.ref_table,
			order = -1000,
		})
	end

	for key, value in pairs(config.tabs) do

		table.insert(tabs, {
			label = value.label or CONFIG_API.UTILS.format_key(key),
			items = value.items,
			tabs = value.tabs,
			path = args.path .. "/" .. key,
			order = value.order,
			ref_table = type(args.ref_table) == "table" and args.ref_table[key] or nil,
		})
	end

	CONFIG_API.UTILS.sort_by_order(tabs)

	if #CONFIG_API.UTILS.keys(config.tabs) == 0 then
		return {
			n = G.UIT.ROOT,
			config = { colour = G.C.CLEAR },
			nodes = {
				{
					n = G.UIT.C,
					config = { padding = 0, colour = G.C.CLEAR },
					nodes = CONFIG_API.BUILDER.build_items(tabs[1] and tabs[1].items or {}),
				},
			},
		}
	else
		local parent_path = CONFIG_API.UTILS.get_parent_path(args.path)
		local back_func = "openModUI_" .. (args.id or "config-api")
		if parent_path ~= nil and parent_path ~= "" then
			back_func = parent_path
		end

		G.FUNCS[args.path] = function()
			CONFIG_API.LAST_SELECTED_TAB = 1
			CONFIG_API.create_menu({
				nodes = { CONFIG_API.create_tabs(tabs) },
				back_func = back_func,
			})
		end
		G.FUNCS[args.path]()
	end
end

---@param config ConfigGroup
function CONFIG_API.BUILDER.build(config, mod_id)
	local ref_table = SMODS.Mods[mod_id].config

	local processed_config = process_config(config)

	if not processed_config then
		sendWarnMessage("Invalid config. Could not find any valid options.", "config-api")
		return nil
	end

	return CONFIG_API.BUILDER.build_menu(processed_config, {
		ref_table = ref_table,
		id = mod_id,
	})
end
