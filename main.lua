CONFIG_API = {}
LOADER_API.init()

function CONFIG_API.init(ui)
	local ref_table = SMODS.current_mod.config
	SMODS.current_mod.config_tab = function()
		local node = CONFIG_API.BUILDER.build(ui, ref_table)
		return node or {}
	end
end

-- uncomment to see example config tab for this mod
-- CONFIG_API.init(CONFIG_API.CONFIG_UI)
