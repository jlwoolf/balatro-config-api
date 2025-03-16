CONFIG_API.UI = CONFIG_API.UI or {}

---@class Deck.UI.Args
---@field deck? Back the deck to create

---creates the card node for the card tab in the config
---@param args? Deck.UI.Args
---@return UI.Node
function CONFIG_API.UI.create_deck(args)
    args = args or {}
    args.deck = args.deck or Back()

	local area = CardArea(
		G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
		G.ROOM.T.h,
		G.CARD_W,
		G.CARD_H,
		{ card_limit = 5, type = "deck", highlight_limit = 0, deck_height = 0.75, thin_draw = 1 }
	)

	G.GAME.viewed_back = args.deck

	for i = 1, 10 do
		local card = Card(
			G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
			G.ROOM.T.h,
			G.CARD_W,
			G.CARD_H,
			pseudorandom_element(G.P_CARDS),
			G.P_CENTERS.c_base,
			{ playing_card = i, viewed_back = true }
		)
		card.sprite_facing = "back"
		card.facing = "back"
		area:emplace(card)
	end

	return { n = G.UIT.O, config = { object = area } }
end