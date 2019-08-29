--[[ Overview

Simple battle mechanics - emphasis is on enemy AI

Actions:
  * Move (WASD)
  * Attack (has hitbox depending on weapon)
  * Dodge (has invulnerability frames)

creatures will have hitboxes which are roughly their shape
or a hitfunction?

# Stage 0:
Rectangular room. Only player combat and player movement

# Stage 1:
Rectangular room. Enemy combat and movement

# Stage 2:
Room with obstacles. Enemy pathfinding

# Stage 3:
Rooms and corridors. Enemy line-of-sight and states

--]]

local entity_manager = require 'ecs.entity_manager'
local system_manager = require 'ecs.system_manager'

local input_manager  = require 'input.manager'
local keyboard_handler = require 'input.handlers.keyboard'
local mouse_handler    = require 'input.handlers.mouse'
local input_scheme     = require 'input.schemes.keyboardmouse_gameplay'

function love.load()
    math.randomseed(os.time())
    math.random(); math.random(); math.random()
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    system_manager.bind(entity_manager)
    system_manager.hook()
    
    for i = 1, 3 do
        local enemy_id = entity_manager.load_entity("ecs_entities_fighter.lua")
        entity_manager.add_component(enemy_id, "non_player_character")
        local sword_id = entity_manager.load_entity("ecs_entities_weapon_sword.lua")
        table.insert(entity_manager.get_component(enemy_id, "fighter").weapons, sword_id)
    end
    local player_id = entity_manager.load_entity("ecs/entities/fighter.lua")
    entity_manager.add_component(player_id, "player_character")
    local sword_id = entity_manager.load_entity("ecs_entities_weapon_sword.lua")
    table.insert(entity_manager.get_component(player_id, "fighter").weapons, sword_id)

    system_manager.load_system("ecs/systems/player_controls.lua", true)
    system_manager.load_system("ecs/systems/enemy_ai.lua", true)
    system_manager.load_system("ecs/systems/combat.lua", true)
    system_manager.load_system("ecs/systems/renderer.lua", true)

    keyboard_handler.load()
    mouse_handler.load()
    input.add_input_scheme(input_scheme)
end

function love.update(dt)
    system_manager.update(dt)
end

function love.draw()
    system_manager.draw()
end