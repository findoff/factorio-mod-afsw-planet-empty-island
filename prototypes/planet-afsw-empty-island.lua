local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")
--local planet_catalogue_gleba = require("__space-age__.prototypes.planet.procession-catalogue-gleba")
--local effects = require("__core__.lualib.surface-render-parameter-effects")

local nauvis = data.raw["planet"]["nauvis"]

local start_astroid_spawn_rate = {
    probability_on_range_chunk = {
        { position = 0.1, probability = asteroid_util.nauvis_chunks, angle_when_stopped = asteroid_util.chunk_angle },
        { position = 0.9, probability = asteroid_util.nauvis_chunks, angle_when_stopped = asteroid_util.chunk_angle }
    },
    type_ratios = {
        { position = 0.1, ratios = asteroid_util.nauvis_ratio },
        { position = 0.9, ratios = asteroid_util.nauvis_ratio },
    }
}

local start_astroid_spawn = asteroid_util.spawn_definitions(start_astroid_spawn_rate, 0.1)

local function createPlanetAfswEmptyIsland()
    local samplePlanet = data.raw["planet"]["nauvis"];
    if (settings.startup["afsw-planet-empty-island-env"].value == "nauvis") then
        samplePlanet = data.raw["planet"]["nauvis"]
        --afswPlanetEmptyIsland.surface_properties = table.deepcopy(data.raw["planet"]["nauvis"].surface_properties)
    end
    if (settings.startup["afsw-planet-empty-island-env"].value == "vulcanus") then
        samplePlanet = data.raw["planet"]["vulcanus"]
        --afswPlanetEmptyIsland.surface_properties = table.deepcopy(data.raw["planet"]["vulcanus"].surface_properties)
    end
    if (settings.startup["afsw-planet-empty-island-env"].value == "gleba") then
        samplePlanet = data.raw["planet"]["gleba"]
        --afswPlanetEmptyIsland.surface_properties = table.deepcopy(data.raw["planet"]["gleba"].surface_properties)
    end
    if (settings.startup["afsw-planet-empty-island-env"].value == "fulgora") then
        samplePlanet = data.raw["planet"]["fulgora"]
        --afswPlanetEmptyIsland.surface_properties = table.deepcopy(data.raw["planet"]["fulgora"].surface_properties)
    end
    if (settings.startup["afsw-planet-empty-island-env"].value == "aquilo") then
        samplePlanet = data.raw["planet"]["aquilo"]
        --afswPlanetEmptyIsland.surface_properties = table.deepcopy(data.raw["planet"]["aquilo"].surface_properties)
    end

    local afswPlanetEmptyIsland = {
        type = "planet",
        name = "afsw-empty-island",
        subgroup = "planets",
        order = "z[planet-afsw-empty-island]",

        icon = "__space-age__/graphics/icons/aquilo.png",
        icon_size = 64,

        distance = 35,
        orientation = 0.55,
        label_orientation = 0.15,

        map_seed = 19, -- Unique seed for consistency
        --map_gen_settings = {
        --    terrain_segmentation = 0.1, -- Low value for smooth, uniform terrain
        --    water = 1000, -- Extremely high water value to cover the planet
        --    autoplace_controls = {
        --        ["water"] = { frequency = 1, size = 1000, richness = 1 }, -- Ensures water dominates
        --        --["iron-ore"] = { frequency = 0, size = 0, richness = 0 }, -- Disable other resources
        --        --["copper-ore"] = { frequency = 0, size = 0, richness = 0 },
        --        --["stone"] = { frequency = 0, size = 0, richness = 0 },
        --        --["coal"] = { frequency = 0, size = 0, richness = 0 },
        --        --["crude-oil"] = { frequency = 0, size = 0, richness = 0 },
        --        --["uranium-ore"] = { frequency = 0, size = 0, richness = 0 }
        --    },
        --    default_enable_all_autoplace = false, -- Only use specified autoplace controls
        --    width = 0,
        --    height = 0,
        --    starting_area = "none",
        --    cliff_settings = { richness = 0 }
        --},

        map_gen_settings = createMapGenSettings(),

        procession_graphic_catalogue = planet_catalogue_gleba,

        magnitude = nauvis.magnitude,
        solar_power_in_space = 200,
        entities_require_heating = false,
        pollutant_type = nil, -- "spores" | "pollution"

        asteroid_spawn_influence = 1,
        asteroid_spawn_definitions = start_astroid_spawn,
        draw_orbit = true,

        surface_properties = {
            ["solar-power"] = samplePlanet.surface_properties["solar-power"],
            ["pressure"] = samplePlanet.surface_properties["pressure"],
            ["magnetic-field"] = samplePlanet.surface_properties["magnetic-field"],
            ["gravity"] = samplePlanet.surface_properties["gravity"],
            ["day-night-cycle"] = samplePlanet.surface_properties["day-night-cycle"],
        },

        --solar_power_percent_multiplier = 1.0, -- Normal solar power
        --robot_attrition_percent_per_distance = 0, -- No robot attrition
        --pollution_settings = {
        --    enabled = false -- No pollution
        --}
    }

    --afswPlanetEmptyIsland.surface_properties["magnetic-field"] = 100
    --afswPlanetEmptyIsland.surface_properties["pressure"] = 4000

    afswPlanetEmptyIsland.orbit = {
        parent = {
            type = "space-location",
            name = "star",
        },
        distance = 32,
        orientation = 0.24,
    }

    data:extend({ afswPlanetEmptyIsland })

    local afswEmptyIslandConnection = {
        type = "space-connection",
        name = "nauvis-afsw-empty-island",
        subgroup = "planet-connections",
        from = "nauvis",
        to = "afsw-empty-island",
        order = 'a',
        length = 30000,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus),
    }
    data:extend { afswEmptyIslandConnection }
end


-- /c helpers.write_file('qwe.txt', serpent.block(game.player.surface.map_gen_settings))

function createMapGenSettings()
    --local map_gen_setting = table.deepcopy(data.raw.planet.nauvis.map_gen_settings)
    local map_gen_setting = {
        autoplace_settings = {},
        property_expression_names = {},
    }

    -- https://lua-api.factorio.com/latest/concepts/PropertyExpressionNames.html
    --map_gen_setting.property_expression_names
    map_gen_setting.property_expression_names.terrain_segmentation = 0.1
    map_gen_setting.property_expression_names.water = 1.5
    map_gen_setting.property_expression_names.elevation = "elevation_island"
    map_gen_setting.property_expression_names.cliffiness = "cliffiness_basic"
    map_gen_setting.property_expression_names.cliff_elevation = "cliff_elevation_from_elevation"
    map_gen_setting.default_enable_all_autoplace_controls = false

    map_gen_setting.starting_area = 2
    map_gen_setting.starting_points = { { 0, 0 } }
    map_gen_setting.no_enemies_mode = true

    map_gen_setting.cliff_settings = {
        name = "cliff",
        control = "nauvis_cliff",
        cliff_smoothing = 0
    }

    map_gen_setting.autoplace_controls = {
        ["water"] = { frequency = 50, size = 2, richness = 1 },
        ["enemy-base"] = { frequency = 4, size = 0, richness = 1 },
        ["stone"] = { frequency = 0.5, size = 0, richness = 2 },
        ["iron-ore"] = { frequency = 0.5, size = 0, richness = 2 },
        ["coal"] = { frequency = 0.5, size = 0, richness = 2 },
        ["copper-ore"] = { frequency = 0.5, size = 0, richness = 2 },
        ["crude-oil"] = { frequency = 1, size = 0, richness = 2 },
        ["trees"] = { frequency = 0.5, size = 0, richness = 1 },
        ["rocks"] = { frequency = 2, size = 0, richness = 1 },
        ["uranium-ore"] = { frequency = 1, size = 0, richness = 1 },
        ["nauvis_cliff"] = { frequency = 2, size = 0, richness = 1 },
    }

    map_gen_setting.autoplace_settings["tile"] = {
        settings = {
            ["dry-dirt"] = {},
            ["water"] = {},
            ["deepwater"] = {},

            --["genfill"] = {},
            --["genwater"] = {},

            --["grass-1"] = {},
            --["grass-2"] = {},
            --["dry-dirt"] = {},
            --["dirt-1"] = {},
            --["dirt-2"] = {},
            --["dirt-3"] = {},
            --["dirt-4"] = {},
            --["dirt-5"] = {},
            --["dirt-6"] = {},
            --["dirt-7"] = {},
            --["sand-1"] = {},
            --["sand-2"] = {},
            --["sand-3"] = {},
            --["red-desert-0"] = {},
            --["red-desert-1"] = {},
            --["red-desert-2"] = {},
            --["red-desert-3"] = {},
            --["water"] = {},
            --["deepwater"] = {},

            --volcanic tiles
            --["volcanic-soil-light"] = {},
            --["volcanic-ash-light"] = {},
        }
    }
    return map_gen_setting
end

createPlanetAfswEmptyIsland()