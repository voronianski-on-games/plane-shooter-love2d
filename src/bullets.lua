local bullets = {}
local bulletImg = nil
local bulletSpeed = 200
local bulletList = {}

function bullets.loadImage ()
  bulletImg = love.graphics.newImage('assets/bullet.png')
end

function bullets.create (player)
  local newBullet = {
    x = player.x + (player.img:getWidth() / 2),
    y = player.y,
    speed = bulletSpeed,
    img = bulletImg
  }

  table.insert(bulletList, newBullet)
end

function bullets.update (dt)
  for i, bullet in ipairs(bulletList) do
    bullet.y = bullet.y - (bullet.speed * dt)

    if bullet.y < 0 then
      table.remove(bulletList, i)
    end
  end
end

function bullets.draw ()
  for i, bullet in ipairs(bulletList) do
    love.graphics.draw(bullet.img, bullet.x, bullet.y)
  end
end

return bullets
