local p = {}

local canShootTimerMax = 0.2
local canShootTimer = canShootTimerMax
local initialX = 200
local initialY = 710
local player = {
  x = initialX,
  y = initialY,
  speed = 150,
  img = nil,
  score = 0,
  isAlive = true,
  canShoot = true
}

function p.loadImage ()
  player.img = love.graphics.newImage('assets/plane.png')
end

function p.getInstance ()
  return player
end

function p.reset ()
  player.x = initialX
  player.y = initialY
  player.score = 0
  player.isAlive = true

  canShootTimer = canShootTimerMax
end

function p.updateShooter (dt)
  canShootTimer = canShootTimer - dt
  if canShootTimer < 0 then
    player.canShoot = true
  end
end

function p.resetShooter ()
  player.canShoot = false
  canShootTimer = canShootTimerMax
end

function p.moveLeft (dt)
  local isNotBorder = player.x > 0

  if isNotBorder then
    player.x = player.x - (player.speed * dt)
  end
end

function p.moveRight (dt)
  local isNotBorder = player.x < (love.graphics.getWidth() - player.img:getWidth())

  if isNotBorder then
    player.x = player.x + (player.speed * dt)
  end
end

function p.score ()
  player.score = player.score + 1
end

function p.remove ()
  player.isAlive = false
end

function p.draw ()
  if player.isAlive then
    love.graphics.draw(player.img, player.x, player.y)
  else
    love.graphics.print(
      'Press \'R\' to restart',
      love.graphics:getWidth() / 2 - 50,
      love.graphics:getHeight() / 2 - 10
    )
  end
end

return p
