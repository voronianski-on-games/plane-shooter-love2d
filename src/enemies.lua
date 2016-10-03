local enemies = {}
local enemiesList = {}
local createEnemyTimerMax = 0.8
local createEnemyTimer = createEnemyTimerMax
local enemyImg = nil
local enemySpeed = 150
local enemyBoomSound = nil

function enemies.loadAssets ()
  enemyImg = love.graphics.newImage('assets/enemy.png')
  enemyBoomSound = love.audio.newSource('assets/boom2.wav', 'static')
end

function enemies.createWithTimer (dt)
  createEnemyTimer = createEnemyTimer - dt

  if createEnemyTimer < 0 then
    createEnemyTimer = createEnemyTimerMax

    local randomNumber = math.random(50, love.graphics.getWidth() - 150)
    local newEnemy = {
      x = randomNumber,
      y = -150,
      speed = enemySpeed,
      img = enemyImg
    }

    table.insert(enemiesList, newEnemy)
  end
end

function enemies.each (cb)
  for i, enemy in ipairs(enemiesList) do
    cb(enemy, i)
  end
end

function enemies.reset ()
  enemiesList = {}
  createEnemyTimer = createEnemyTimerMax
end

function enemies.update (dt)
  enemies.each(function (enemy, i)
    enemy.y = enemy.y + (enemy.speed * dt)

    if enemy.y > 850 then
      enemies.remove(i)
    end
  end)
end

function enemies.boom ()
  enemyBoomSound:play()
end

function enemies.remove (index)
  table.remove(enemiesList, index)
end

function enemies.draw ()
  enemies.each(function (enemy)
    love.graphics.draw(enemy.img, enemy.x, enemy.y)
  end)
end

return enemies
