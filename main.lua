push = require('push')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WINDOW_WIDTH = 432
VIRTUAL_WINDOW_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest') -- This helps with the texteure filtering, 
  -- making it look pixelated since the goal is to make it look retro.

  smallFont = love.graphics.newFont('font.ttf', 8)

  scoreFont = love.graphics.newFont("font.ttf", 32)

  push:setupScreen(VIRTUAL_WINDOW_WIDTH, VIRTUAL_WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  player_1_score = 0
  player_2_score = 0

  -- Paddle positions
  player1Y = 30
  player2Y = VIRTUAL_WINDOW_HEIGHT - 50

  -- we transitioned to using the push library for window management to help
  -- with scaling and resolution management, it kind of zooms in to the virtual resolution but
  -- it also allows us to use the normal resolution for the window
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
  -- Player 1 movement
  addable = 0
  if love.keyboard.isDown("w") then
    if player1Y <= -2 then
      addable = player1Y
    else
      addable = player1Y - (PADDLE_SPEED * dt)
    end
    player1Y = addable
  elseif love.keyboard.isDown("s") then
    if player1Y >= 221 then
      addable = player1Y
    else
      addable = player1Y + (PADDLE_SPEED * dt)
    end
    player1Y = addable
  end
  -- Player 2 movement
  if love.keyboard.isDown("up") then
    if player2Y <= -2 then
      addable = player2Y
    else
      addable = player2Y - (PADDLE_SPEED * dt)
    end
    player2Y = addable
  elseif love.keyboard.isDown("down") then
    if player2Y >= 221 then
      addable = player2Y
    else
      addable = player2Y + (PADDLE_SPEED * dt)
    end
    player2Y = addable
  end

end

function love.draw()
  push:apply('start')
  love.graphics.clear(40/255, 45/255, 52/255, 255/255)
  love.graphics.setFont(smallFont)
  love.graphics.printf('Hello Pong', 0, 30, VIRTUAL_WINDOW_WIDTH, 'center')

  love.graphics.setFont(scoreFont)
  love.graphics.print(tostring(player_1_score), VIRTUAL_WINDOW_WIDTH / 2 - 50, 15)
  love.graphics.print(tostring(player_2_score), VIRTUAL_WINDOW_WIDTH / 2 + 30, 15)

  -- Paddle 1
  love.graphics.rectangle("fill", 10, player1Y, 5, 20)
  -- Paddle 2
  love.graphics.rectangle("fill", VIRTUAL_WINDOW_WIDTH - 10, player2Y, 5, 20)
  -- Ball
  love.graphics.rectangle("fill", VIRTUAL_WINDOW_WIDTH / 2 - 2, VIRTUAL_WINDOW_HEIGHT / 2 - 2, 4, 4)
  push:apply('end')
end