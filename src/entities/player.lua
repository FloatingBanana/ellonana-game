local Vector2 = require "engine.vector2"
local InputHelper = require "engine.inputHelper"
local Body = require "entities.body"
local Player = Body:extend()

function Player:new(world, position)
    Body.new(self, world, position, Vector2(32, 32))

    self.speed = Vector2(100, 1500)
    self.gravity = 0
    self.jumpStrength = 500
    self.canJump = false
end

function Player:update(dt)
    self.gravity = self.gravity + self.speed.y * dt

    local movement = Vector2(
        InputHelper.getAxis("horizontal") * self.speed.x,
        self.gravity
    )

    self:move(movement * dt)

    self.canJump = self.gravity == 0
end

function Player:onCollision(col)
    if col.normal.y == -1 then
        self.gravity = 0
    end
end

function Player:keypressed(key)
    if InputHelper.getAction("jump") and self.canJump then
        self.gravity = -self.jumpStrength
    end
end

return Player
