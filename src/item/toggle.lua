---@class Toggle.Args: Callbacks.Args
---@field active_colour? Color the active color of the toggle. Defaults to G.C.RED
---@field inactive_colour? Color the inactive color of the toggle. Defaults to G.C.BLACK
---@field col? boolean to use G.UIT.C rather than G.UIT.R
---@field w? number the width of the toggle. Defaults to 3
---@field h? number the height of the toggle. Defaults to 0.5
---@field scale? number the scale of the toggle. Defaults to 1
---@field label? string the label of the toggle. Defaults to "TEST?"
---@field label_scale? number the scale of the label. Defaults to 0.4
---@field info? string[] additional info associated with the toggle

---@class Toggle.WithType: Toggle.Args
---@field type 'toggle'

---@class Toggle.WithApiType: Toggle.Args
---@field config_api_type 'toggle'

---@alias Toggle Toggle.WithType|Toggle.WithApiType

---@type fun(args: Toggle.Args): UI.Node creates a toggle
function CONFIG_API.create_toggle(args)
	args.w = args.w or 1

	return create_toggle(args)
end
