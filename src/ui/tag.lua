---@class Tag.Args
---@field scale? number scale of the tag sprite. Defaults to 1
---@field size? number the size of the sprite
---@field pos? { x: number, y: number } the position in the atlas of the sprite
---@field atlas? string the atlas for the sprite

---creates the tag node for the tag tab in the config
---@return UI.Node
function CONFIG_API.create_tag(args)
	args = args or {}
	args.scale = args.scale or 1
	args.size = args.size or 0.8
	args.pos = args.pos or { x = 0, y = 0 }
	args.atlas = args.atlas or "tags"

	--- copied over from Tag:generate_UI but removed dependencies that come from
	--- actual tag definition. This way sprite can render without tag enabled
	local tag_sprite =
		Sprite(0, 0, args.size * 1, args.size * 1, G.ASSET_ATLAS[args.atlas], args.pos)
	tag_sprite.T.scale = args.scale
	tag_sprite.float = true
	tag_sprite.states.hover.can = true
	tag_sprite.states.drag.can = false
	tag_sprite.states.collide.can = true
	tag_sprite.config = { force_focus = true }

	tag_sprite:define_draw_steps({
		{ shader = "dissolve", shadow_height = 0.05 },
		{ shader = "dissolve" },
	})

	tag_sprite.hover = function(_self)
		if not G.CONTROLLER.dragging.target or G.CONTROLLER.using_touch then
			if not _self.hovering and _self.states.visible then
				_self.hovering = true
				if _self == tag_sprite then
					_self.hover_tilt = 3
					_self:juice_up(0.05, 0.02)
					play_sound("paper1", math.random() * 0.1 + 0.55, 0.42)
					play_sound("tarot2", math.random() * 0.1 + 0.55, 0.09)
				end

				Node.hover(_self)
				if _self.children.alert then
					_self.children.alert:remove()
					_self.children.alert = nil
					G:save_progress()
				end
			end
		end
	end

	tag_sprite.stop_hover = function(_self)
		_self.hovering = false
		Node.stop_hover(_self)
		_self.hover_tilt = 0
	end

	local tag_sprite_tab = {
		n = G.UIT.C,
		config = { align = "cm" },
		nodes = {
			{
				n = G.UIT.O,
				config = {
					w = 0.8,
					h = 0.8,
					colour = G.C.BLUE,
					object = tag_sprite,
					focus_with_object = true,
				},
			},
		},
	}

	return {
		n = G.UIT.C,
		config = { align = "cm", padding = 0.1 },
		nodes = {
			tag_sprite_tab,
		},
	}
end
