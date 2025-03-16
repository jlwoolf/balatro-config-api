---@alias Color [number,number,number,number]

---@class Item
---@field order? number

---@class UI.Tooltip
---@field title string
---@field text string[]

---@class UI.Config
---@field align? 'tl'|'tm'|'tr'|'cl'|'cm'|'cr'|'bl'|'bm'|'br' where the child nodes are placed within the current node. First letter is *vertical* alignment, second is *horizontal* alignment
---@field h? number fixed height of the node
---@field minh? number minimum height of the node
---@field maxh? number maximum height of the node
---@field w? number fixed width of the node
---@field minw? number minimum width of the node
---@field maxw? number maximum width of the node
---@field padding? number padding around the node
---@field r? number radius of the node's corners
---@field colour? Color color of the node
---@field no_fill? boolean whether the node should not be filled with color
---@field outline? number thickness of the node's outline
---@field outline_colour? Color color of the node's outline
---@field emobss? number emotional bossiness level (if applicable)
---@field hover? boolean whether the node reacts to hover events
---@field shadow? number shadow intensity of the node
---@field juice? number juice level of the node (if applicable)
---@field id? string unique identifier for the node
---@field ref_table? table reference table for the node
---@field ref_value? string reference value within the table
---@field func string set a function that will be called when the current node is being drawn. Its value is a string of the function name; the function itself must be stored in `G.FUNCS`
---@field button string set a function that will be called when the current node is clicked on. Its value is a string of the function name; the function itself must be stored in `G.FUNCS`
---@field tooltip UI.Tooltip add a tooltip when the current node is hovered over by a mouse/controller.
---@field detailed_tooltip UI.Tooltip

---@class UI.Config.Text: UI.Config
---@field text? string set the string to display. can use `ref_table` and `ref_value` as well
---@field scale? number set a multiplier to text size.
---@field colour? Color set the text colour.
---@field vert? boolean draw the text vertically

---@class UI.Config.Object: UI.Config
---@field object Object set the object to render.

---@class UI.Node
---@field n integer node type. Integer from `G.UIT`
---@field config UI.Config|UI.Config.Text|UI.Config.Object configuration for the node
---@field nodes UI.Node[] child nodes