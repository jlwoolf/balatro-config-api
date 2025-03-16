---@class Option.Args: Callbacks.Args
---@field colour? Color the color of the option. Defaults to G.C.RED
---@field options? string[] the list of options available. Defaults to {'Option 1', 'Option 2'}
---@field current_option? number the index of the currently selected option. Defaults to 1
---@field current_option_val? string the value of the currently selected option
---@field opt_callback? fun(option: string) callback fired when an option is selected
---@field scale? number the scale of the option. Defaults to 1
---@field w? number the width of the option. Defaults to 2.5
---@field h? number the height of the option. Defaults to 0.8
---@field text_scale? number the scale of the text. Defaults to 0.5
---@field l? string the left indicator for cycling options. Defaults to '<'
---@field r? string the right indicator for cycling options. Defaults to '>'
---@field focus_args? table additional focus arguments for the option
---@field no_pips? UI.Node
---@field cycle_shoulders? boolean
---@field label? string
---@field info? string[]

---@class Option.WithType: Option.Args
---@field type 'option'

---@class Option.WithApiType: Option.Args
---@field config_api_type 'option'

---@alias Option Option.WithType|Option.WithApiType

---@param args Option.Args
---@return UI.Node
function CONFIG_API.create_option(args)
	local option = create_option_cycle(args)

	args.callback = CONFIG_API.CALLBACKS.create_callback({
		variant = "option",
		callback = args.callback,
		ref_table = args,
		ref_value = "current_option_val",
	})

	return option
end
