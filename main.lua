push = require('push')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WINDOW_WIDTH = 432
VIRTUAL_WINDOW_HEIGHT = 243


function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  smallFont = love.graphics.newFont('font.ttf', 8)

  love.graphics.setFont(smallFont)

  push:setupScreen(VIRTUAL_WINDOW_WIDTH, VIRTUAL_WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })
  -- love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
  --   fullscreen = false,
  --   resizable = false,
  --   vsync = true
  -- })
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end

function love.update(dt)

end

function love.draw()
  push:apply('start')
  love.graphics.clear(40/255, 45/255, 52/255, 255/255)
  love.graphics.printf('Hello World', 0, 30, VIRTUAL_WINDOW_WIDTH, 'center')

  -- Paddle 1
  love.graphics.rectangle("fill", 10, 30, 5, 20)
  -- Paddle 2
  love.graphics.rectangle("fill", VIRTUAL_WINDOW_WIDTH - 10, VIRTUAL_WINDOW_HEIGHT - 50, 5, 20)
  -- Ball
  love.graphics.rectangle("fill", VIRTUAL_WINDOW_WIDTH / 2 - 2, VIRTUAL_WINDOW_HEIGHT / 2 - 2, 4, 4)
  push:apply('end')
end