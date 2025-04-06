data:extend({
    {
        type = "technology",
        name = "planet-discovery-afsw-empty-island",
        icon = "__base__/graphics/technology/landfill.png",
        icon_size = 256,
        order = "z-a",
        prerequisites = {},
        unit = {
            count = 10,
            ingredients = {
                { "automation-science-pack", 1 },
            },
            time = 15,
        },
        effects = {
            {
                type = "unlock-space-location",
                space_location = "afsw-empty-island",
            },
            { type = "unlock-recipe", recipe = "landfill" },
        },
    },
})

