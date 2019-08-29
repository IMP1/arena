return {
    name = "fighter",
    components = {
        moveable = {
            speed = 64, -- pixels per second
            path = nil,
        },
        location = {
            position = {100, 100, 1},
        },
        renderable = {
            visible = true,
            colour  = {1, 1, 1},
            texture = love.graphics.newImage("res/gfx/worker_male.png"),
            quad    = love.graphics.newQuad(32, 0, 32, 48, 96, 192),
            offset  = {16, 48},
        },
        destructible = {
            health = 100,
        },
        fighter = {
            weapons = {}, -- ids of weapon entities
            armours = {}, -- ids of armour entities
        },
    },
}