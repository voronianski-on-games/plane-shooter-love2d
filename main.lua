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
  local playerData = player.getInstance()

  if love.keyboard.isDown('lcmd') and love.keyboard.isDown('q') then
    love.event.push('quit')
  end

  if love.keyboard.isDown('r') then
    bullets.reset()
    player.reset()
    enemies.reset()
  end

  player.updateShooter(dt)
  enemies.createWithTimer(dt)
  bullets.update(dt)
  enemies.update(dt)

  -- collision detection
  enemies.each(function (enemy, enemyIndex)
    bullets.each(function (bullet, bulletIndex)
      if _checkCollision(enemy, bullet) then
        bullets.remove(bulletIndex)
        enemies.remove(enemyIndex)
        player.score()
      end
    end)

    if _checkCollision(enemy, playerData) and playerData.isAlive then
      enemies.remove(enemyIndex)
      player.remove()
    end
  end)

  if love.keyboard.isDown('x') and playerData.canShoot then
    bullets.create(playerData)
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

-- Collision detection taken function from http://love2d.org/wiki/BoundingBox.lua
-- Returns true if two boxes overlap, false if they don't
function _checkCollision(entity1, entity2)
  return (
    entity1.x < (entity2.x + entity2.img:getWidth()) and
    entity2.x < (entity1.x + entity1.img:getWidth()) and
    entity1.y < (entity2.y + entity2.img:getHeight()) and
    entity2.y < (entity1.y + entity1.img:getHeight())
  )
end
