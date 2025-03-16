# Balatro Config API

This is a mod created with the intent of simplifying mod configuration. The idea is that you just have to define a ui configuration with minimal attributes, and a config tab will be generated for your mod. This mod depends on my [loader-api](https://github.com/jlwoolf/balatro-loader-api), so make sure you have that installed. Documentation follows the convention outlined in my loader-api.

## Usage

To use the api, add it as a dependency to your mod and make sure your mods priority is higher than the `-0.9` default priority for this mod. Then, inside your `config.lua` create a table that defines your config tab.

`config.lua`

```lua
["{{MOD_ID}}"].CONFIG = {
    ["enabled"] = true,
    ["some_toggle"] = false,
    ["some_slider"] = 50
    ["some_option"] = "1"
}

["{{MOD_ID}}"].CONFIG_UI = {
    ["some_toggle"] = {
        type = "toggle",
        label = "Some Toggle"
    },
    ["some_slider"] = {
        type = "slider",
        label = "Some Slider"
    },
    ["some_option"] = {
        type = "option",
        label = "Some Option"
        options = { "1", "2", "3" }
    }
}
```

Next call `CONFIG_API.init()` with your defined config ui.

`main.lua`

```lua
["{{MOD_ID}}"] = {} -- global variable to associate your config and mod functions with.

LOADER_API.init()
CONFIG_API.init(["{{MOD_ID}}"].CONFIG_UI)
```

## Input Types

There are 4 input types currently available to use, `toggle`, `slider`, `option`, and `custom`. They can be created automatically using the `CONFIG_API.init()` function, or manually, using their respective create functions.

### Toggle

`CONFIG_API.create_toggle`

```lua
---@class Toggle
---@field type "toggle"
---@field order? number the order this item appears in the config window
---@field active_colour? Color the active color of the toggle. Defaults to G.C.RED
---@field inactive_colour? Color the inactive color of the toggle. Defaults to G.C.BLACK
---@field col? boolean to use G.UIT.C rather than G.UIT.R
---@field w? number the width of the toggle. Defaults to 3
---@field h? number the height of the toggle. Defaults to 0.5
---@field scale? number the scale of the toggle. Defaults to 1
---@field label? string the label of the toggle. Defaults to "TEST?"
---@field label_scale? number the scale of the label. Defaults to 0.4
---@field info? string[] additional info associated with the toggle
---@field callback? fun(value: boolean) callback function called on toggle
---@field ref_table? table
---@field ref_value? string
```

### Slider

`CONFIG_API.create_slider`

```lua
---@class Slider
---@field type "slider"
---@field order? number the order this item appears in the config window
---@field colour? Color the color of the slider. Defaults to G.C.RED
---@field w? number the width of the slider. Defaults to 1
---@field h? number the height of the slider. Defaults to 0.5
---@field label? string a label for the slider
---@field label_scale? number the scale of the label. Defaults to 0.5
---@field text_scale? number the scale of the text. Defaults to 0.3
---@field min? number the minimum value of the slider. Defaults to 0
---@field max? number the maximum value of the slider. Defaults to 1
---@field decimal_places? number the number of decimal places for the slider value. Defaults to 0
---@field callback? fun(value: number) callback function called on slide
---@field ref_table? table
---@field ref_value? string
```

### Option

`CONFIG_API.create_option`

```lua
---@class Option
---@field type "option"
---@field order? number the order this item appears in the config window
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
---@field callback? fun(value: number) callback function called on select
---@field ref_table? table
---@field ref_value? string
```

### Custom

This is a custom item, so there is no create function. Instead, provide a `build` function that takes the custom item as it's input and returns a valid UI node (see the [UI Guide](https://github.com/Steamodded/smods/wiki/UI-Guide)).

```lua
---@class Custom
---@field type "custom"
---@field order? number the order this item appears in the config window
---@field build fun(args: Custom): UI.Node[]
```

**e.g.**

```lua
custom = {
    order = 2,
    type = "custom",
    build = function()
        return {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = { -- Example node:
                {
                    n = G.UIT.C,
                    config = { align = "cm", padding = 0.1, colour = G.C.BLUE, r = 0.5 },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = { text = "Hello, world!", colour = G.C.UI.TEXT_LIGHT, scale = 0.5 },
                        },
                    },
                },
            },
        }
    end,
},
```

## Tabs

If you need a bit more organization in your configuration, the api will automatically create tabs. To do so, just create nested configs within your main config.

**e.g.**

```lua
["{{MOD_ID}}"].CONFIG_UI = {
    nested_tabs = {
        order = 2,
        config_api_label = "Nested Tabs",
        tab1 = {
            config_api_label = "Tab 1",
            tab1 = {
                config_api_label = "Tab 1, 1",
                toggle = {
                    type = "toggle",
                },
            },
            tab2 = {
                config_api_label = "Tab 1, 2",
                toggle = {
                    type = "toggle",
                },
            },
        },
        tab2 = {
            config_api_label = "Tab 2",
            tab1 = {
                config_api_label = "Tab 2, 1",
                toggle = {
                    type = "toggle",
                },
            },
            tab2 = {
                config_api_label = "Tab 2, 2",
                toggle = {
                    type = "toggle",
                },
            },
        },
    },
}
```
