local enemies = {}
local enemiesList = {}
local createEnemyTimerMax = 0.8
local createEnemyTimer = createEnemyTimerMax
local enemyImg = nil
local enemySpeed = 150

function enemies.loadImage ()
  enemyImg = love.graphics.newImage('assets/enemy.png')
end

function enemies.createWithTimer (dt)
  createEnemyTimer = createEnemyTimer - dt

  if createEnemyTimer < 0 then
    createEnemyTimer = createEnemyTimerMax

    local randomNumber = math.random(10, love.graphics.getWidth() - 10)
    local newEnemy = {
      x = randomNumber,
      y = -150,
      speed = enemySpeed,
      img = enemyImg
    }

    table.insert(enemiesList, newEnemy)
  end
end

function enemies.update (dt)
  for i, enemy in ipairs(enemiesList) do
    enemy.y = enemy.y + (enemy.speed * dt)

    if enemy.y > 850 then
      table.remove(enemiesList, i)
    end
  end
end

function enemies.draw ()
  for i, enemy in ipairs(enemiesList) do
    love.graphics.draw(enemy.img, enemy.x, enemy.y)
  end
end

return enemies
