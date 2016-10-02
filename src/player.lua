local p = {}
local player = {
  x = 200,
  y = 710,
  speed = 150,
  img = nil
}
local canShoot = true
local canShootTimerMax = 0.2
local canShootTimer = canShootTimerMax

function p.load ()
  player.img = love.graphics.newImage('assets/plane.png')
end

function p.getInstance ()
  return player
end

function p.canShoot ()
  return canShoot
end

function p.updateShooter (dt)
  canShootTimer = canShootTimer - dt
  if canShootTimer < 0 then
    canShoot = true
  end
end

function p.resetShooter ()
  canShoot = false
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

function p.draw ()
  love.graphics.draw(player.img, player.x, player.y)
end

return p
