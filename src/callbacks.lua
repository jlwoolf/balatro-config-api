CONFIG_API.CALLBACKS = {
	slider = {},
	toggle = {},
	input = {},
	option = {},
}

---@class Callbacks.Args
---@field callback? fun(value: any)
---@field ref_table? table
---@field ref_value? string

---@param args Callbacks.Args
---@param default any
function CONFIG_API.CALLBACKS.configure_args(args, default)
	args.ref_table = args.ref_table or {}
	args.ref_value = args.ref_value or "value"
	args.ref_table[args.ref_value] = args.ref_table[args.ref_value] or default
end

---@class Callbacks.CreateArgs: Callbacks.Args
---@field variant 'slider'|'toggle'|'input'|'option'

---create a callback for an input variant
---@param args Callbacks.CreateArgs
function CONFIG_API.CALLBACKS.create_callback(args)
	if type(args.callback) ~= "function" then
		return args.callback
	end

	local callback_index = #CONFIG_API.CALLBACKS[args.variant] + 1
	CONFIG_API.CALLBACKS[args.variant][callback_index] = args.callback

	local G_update_ref = G.update
	local prev_value = args.ref_table[args.ref_value]
	function G:update(dt)
		-- G_update_ref(self, dt)

		-- if prev_value ~= args.ref_table[args.ref_value] then
		-- 	CONFIG_API.CALLBACKS[args.variant][callback_index](args.ref_table[args.ref_value])
		-- 	prev_value = args.ref_table[args.ref_value]
		-- end
	end
end
