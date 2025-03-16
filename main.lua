CONFIG_API = {}
LOADER_API.init()

function CONFIG_API.init()
	local ref_table = SMODS.current_mod.config
	SMODS.current_mod.config_tab = function()
		local node = CONFIG_API.BUILDER.build(CONFIG_API.CONFIG_UI, ref_table)
		return node or {}
	end
end

CONFIG_API.init()
