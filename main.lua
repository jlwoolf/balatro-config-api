CONFIG_API = {}
LOADER_API.init()

function CONFIG_API.init(ui)
	local id = SMODS.current_mod.id
	SMODS.current_mod.config_tab = function()
		local node = CONFIG_API.BUILDER.build(ui, id)
		return node or {}
	end
end

-- uncomment to see example config tab for this mod
-- CONFIG_API.init(CONFIG_API.CONFIG_UI)
