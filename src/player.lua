local player = {}

local canShootTimerMax = 0.2
local canShootTimer = canShootTimerMax
local initialX = 200
local initialY = 710
local playerData = {
  x = initialX,
  y = initialY,
  speed = 150,
  img = nil,
  score = 0,
  isAlive = true,
  canShoot = true
}

function player.loadImage ()
  playerData.img = love.graphics.newImage('assets/plane.png')
end

function player.data ()
  return playerData
end

function player.reset ()
  playerData.x = initialX
  playerData.y = initialY
  playerData.score = 0
  playerData.isAlive = true

  canShootTimer = canShootTimerMax
end

function player.updateShooter (dt)
  canShootTimer = canShootTimer - dt
  if canShootTimer < 0 then
    playerData.canShoot = true
  end
end

function player.resetShooter ()
  playerData.canShoot = false
  canShootTimer = canShootTimerMax
end

function player.moveLeft (dt)
  local isNotBorder = playerData.x > 0

  if isNotBorder then
    playerData.x = playerData.x - (playerData.speed * dt)
  end
end

function player.moveRight (dt)
  local isNotBorder = playerData.x < (love.graphics.getWidth() - playerData.img:getWidth())

  if isNotBorder then
    playerData.x = playerData.x + (playerData.speed * dt)
  end
end

function player.score ()
  playerData.score = playerData.score + 1
end

function player.remove ()
  playerData.isAlive = false
end

function player.draw ()
  if playerData.isAlive then
    love.graphics.draw(playerData.img, playerData.x, playerData.y)
  else
    love.graphics.print(
      'Press \'R\' to restart',
      love.graphics:getWidth() / 2 - 50,
      love.graphics:getHeight() / 2 - 10
    )
  end
end

return player
