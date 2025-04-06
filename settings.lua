--local APS = mods["any-planet-start"]

if APS then
    APS.add_choice("afsw-empty-island")
    --APS.set_default_choice("afsw-empty-island")
end

data:extend({
    {
        type = "string-setting",
        name = "afsw-planet-empty-island-env",
        setting_type = "startup",
        default_value = "nauvis",
        --allowed_values = { "nauvis", "super" },
        allowed_values = {
            "nauvis",
            "vulcanus",
            "gleba",
            "fulgora",
            "aquilo",
            --"shattered-planet",
            --"solar-system-edge",
        },
    },
})

