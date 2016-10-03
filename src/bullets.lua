local bullets = {}
local bulletImg = nil
local bulletSpeed = 200
local bulletsList = {}

function bullets.loadAssets ()
  bulletImg = love.graphics.newImage('assets/bullet2.png')
end

function bullets.create (player)
  local newBullet = {
    x = player.x + (player.img:getWidth() / 2),
    y = player.y,
    speed = bulletSpeed,
    img = bulletImg
  }

  table.insert(bulletsList, newBullet)
end

function bullets.reset ()
  bulletsList = {}
end

function bullets.each (cb)
  for i, bullet in ipairs(bulletsList) do
    cb(bullet, i)
  end
end

function bullets.update (dt)
  bullets.each(function (bullet, i)
    bullet.y = bullet.y - (bullet.speed * dt)

    if bullet.y < 0 then
      bullets.remove(i)
    end
  end)
end

function bullets.remove (index)
  table.remove(bulletsList, index)
end

function bullets.draw ()
  bullets.each(function (bullet)
    love.graphics.draw(bullet.img, bullet.x, bullet.y)
  end)
end

return bullets
