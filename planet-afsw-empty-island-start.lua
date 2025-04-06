local utils = require("__any-planet-start__/utils") --[[@as APS.utils]]

if (mods["Voidcraft"]) then
    utils.set_trigger("s6x-voidcraft", { type = "craft-item", item = "iron-gear-wheel" })
    data:extend({
        {
            type = "recipe",
            name = "afsw-manual-gen-res-basic",
            enabled = true,
            --category = "smelting",
            icons = {
                {
                    icon = "__base__/graphics/icons/stone.png",
                    size = 64,
                    scale = 1,
                    tint = {1, 0, 1},
                },
            },
            category = "recycling-or-hand-crafting",
            ingredients = {
                --{ type = "item", name = "iron-plate", amount = 1 },
            },
            results = {
                { type = "item", name = "coal", amount = 1, probability = 0.5 },
                { type = "item", name = "stone", amount = 1, probability = 0.5 },
                { type = "item", name = "iron-ore", amount = 1, probability = 0.5 },
                { type = "item", name = "copper-ore", amount = 1, probability = 0.5 },
            },
        },
    })
end

