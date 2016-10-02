debug = true

local player = require('./src/player')
local bullets = require('./src/bullets')

function love.load()
  player.load()
  bullets.load()
end

function love.update(dt)
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end

  player.updateShooter(dt)
  bullets.update(dt)

  if love.keyboard.isDown('x') and player.canShoot() then
    bullets.create(player.getInstance())
    player.resetShooter()
  end

  if love.keyboard.isDown('left', 'a') then
    player.moveLeft(dt)
  elseif love.keyboard.isDown('right',  'd') then
    player.moveRight(dt)
  end
end

function love.draw(dt)
  bullets.draw()
  player.draw()

  if debug then
    local fps = tostring(love.timer.getFPS())
    love.graphics.print('Current FPS: ' .. fps, 10, 10)
  end
end
