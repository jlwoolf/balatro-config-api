---@class Input.Args: Callbacks.Args
---@field colour? Color the color of the input field. Defaults to a copy of G.C.BLUE
---@field hooked_colour? Color the color of the input field when hooked. Defaults to a darkened copy of G.C.BLUE
---@field w? number the width of the input field. Defaults to 2.5
---@field h? number the height of the input field. Defaults to 0.7
---@field text_scale? number the scale of the text. Defaults to 0.4
---@field max_length? number the maximum length of the input text. Defaults to 16
---@field all_caps? boolean whether the input text should be in all caps. Defaults to false
---@field prompt_text? string the prompt text displayed in the input field. Defaults to localized 'k_enter_text'

---@class Input.WithType: Input.Args
---@field type 'input'

---@class Input.WithApiType: Input.Args
---@field config_api_type 'input'

---@alias Input Input.WithType|Input.WithApiType

---@type fun(args: Input.Args): UI.Node
function CONFIG_API.create_input(args)
	CONFIG_API.CALLBACKS.configure_args(args, "")

	local input = create_text_input(args)

	args.callback = CONFIG_API.CALLBACKS.create_callback({
		variant = "input",
		callback = args.callback,
		ref_table = args.ref_table,
		ref_value = args.ref_value,
	})

	return input
end
