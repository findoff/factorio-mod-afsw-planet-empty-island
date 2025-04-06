
script.on_init(function()

    if remote.interfaces["freeplay"] then
        log("aaaaaaaaaaaaaaaaaa")
        local b = remote.call("freeplay", "get_ship_items")
        log(b)
        --storage.crashed_debris_items = remote.call("freeplay", "get_debris_items")
        --storage.crashed_ship_parts = remote.call("freeplay", "get_ship_parts")
        --storage.custom_intro_message = remote.call("freeplay", "get_custom_intro_message")
    end

end)
