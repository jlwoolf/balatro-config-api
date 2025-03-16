---@class Slider.Args: Callbacks.Args
---@field colour? Color the color of the slider. Defaults to G.C.RED
---@field w? number the width of the slider. Defaults to 1
---@field h? number the height of the slider. Defaults to 0.5
---@field label? string a label for the slider
---@field label_scale? number the scale of the label. Defaults to 0.5
---@field text_scale? number the scale of the text. Defaults to 0.3
---@field min? number the minimum value of the slider. Defaults to 0
---@field max? number the maximum value of the slider. Defaults to 1
---@field decimal_places? number the number of decimal places for the slider value. Defaults to 0

---@class Slider.WithType: Slider.Args
---@field type 'slider'

---@class Slider.WithApiType: Slider.Args
---@field config_api_type 'slider'

---@alias Slider Slider.WithType|Slider.WithApiType

---@param args Slider.Args
---@return UI.Node
function CONFIG_API.create_slider(args)
	CONFIG_API.CALLBACKS.configure_args(args, 0.5)

	local slider = create_slider(args)

	if not args.label then
		slider = { n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
			slider,
		} }
	end

	args.callback = CONFIG_API.CALLBACKS.create_callback({
		variant = "slider",
		callback = args.callback,
		ref_table = args.ref_table,
		ref_value = args.ref_value,
	})

	return slider
end
