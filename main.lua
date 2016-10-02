debug = true

local player = require('./src/player')
local bullets = require('./src/bullets')
local enemies = require('./src/enemies')

function love.load()
  player.loadImage()
  bullets.loadImage()
  enemies.loadImage()
end

function love.update(dt)
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end

  player.updateShooter(dt)
  enemies.createWithTimer(dt)
  bullets.update(dt)
  enemies.update(dt)

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

function love.draw()
  bullets.draw()
  player.draw()
  enemies.draw()

  if debug then
    local fps = tostring(love.timer.getFPS())
    love.graphics.print('Current FPS: ' .. fps, 10, 10)
  end
end
