push = require('push')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WINDOW_WIDTH = 432
VIRTUAL_WINDOW_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest') -- This helps with the texteure filtering, 
  -- making it look pixelated since the goal is to make it look retro.

  math.randomseed(os.time()) -- This is used to seed the random number generator with the current time.

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

  ballX = VIRTUAL_WINDOW_WIDTH / 2 - 2
  ballY = VIRTUAL_WINDOW_HEIGHT / 2 - 2

  ballDX = math.random(2) == 1 and 100 or -100 -- randomly set the direction of the ball
  ballDY = math.random(-50, 50) -- randomly set the vertical direction of the ball

  -- we transitioned to using the push library for window management to help
  -- with scaling and resolution management, it kind of zooms in to the virtual resolution but
  -- it also allows us to use the normal resolution for the window
  -- love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
  --   fullscreen = false,
  --   resizable = false,
  --   vsync = true
  -- })

  gameState = 'start' -- This is used to keep track of the game state, whether it's in the start screen or playing.
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
  if key == "enter" or key == "return" then
    if gameState == "start" then
      gameState = "play"
    else
      gameState = "start"
      ballX = VIRTUAL_WINDOW_WIDTH / 2 - 2
      ballY = VIRTUAL_WINDOW_HEIGHT / 2 - 2

      ballDX = math.random(2) == 1 and 100 or -100
      ballDY = math.random(-50, 50) * 1.5
    end
  end
  if key == "space" then
    ballX = VIRTUAL_WINDOW_WIDTH / 2 - 2
    ballY = VIRTUAL_WINDOW_HEIGHT / 2 - 2
  end
end

function love.update(dt)
  -- Player 1 movement
  if love.keyboard.isDown("w") then
    player1Y = math.max(0, player1Y - (PADDLE_SPEED * dt))
  elseif love.keyboard.isDown("s") then
    player1Y = math.min(VIRTUAL_WINDOW_HEIGHT - 20, player1Y + (PADDLE_SPEED * dt))
  end
  -- Player 2 movement
  if love.keyboard.isDown("up") then
    player2Y = math.max(0, player2Y - (PADDLE_SPEED * dt))
  elseif love.keyboard.isDown("down") then
    player2Y = math.min(VIRTUAL_WINDOW_HEIGHT - 20, player2Y + (PADDLE_SPEED * dt))
  end

  -- Ball movement
  if gameState == "play" then
    ballX = ballX + ballDX * dt
    ballY = ballY + ballDY * dt
  end
end

function love.draw()
  push:apply('start')
  love.graphics.clear(40/255, 45/255, 52/255, 255/255)
  love.graphics.setFont(smallFont)
  if gameState == 'start' then
    love.graphics.printf('Welcome to Pong!', 0, 10, VIRTUAL_WINDOW_WIDTH, 'center')
    love.graphics.printf('Press Enter to Start', 0, 20, VIRTUAL_WINDOW_WIDTH, 'center')
  end
  if gameState == 'play' then
    love.graphics.printf('Playing!', 0, 10, VIRTUAL_WINDOW_WIDTH, 'center')
    love.graphics.printf('Press Enter to Pause', 0, 20, VIRTUAL_WINDOW_WIDTH, 'center')
  end

  love.graphics.setFont(scoreFont)
  love.graphics.print(tostring(player_1_score), VIRTUAL_WINDOW_WIDTH / 2 - 70, 15)
  love.graphics.print(tostring(player_2_score), VIRTUAL_WINDOW_WIDTH / 2 + 50, 15)

  -- Paddle 1
  love.graphics.rectangle("fill", 10, player1Y, 5, 20)
  -- Paddle 2
  love.graphics.rectangle("fill", VIRTUAL_WINDOW_WIDTH - 10, player2Y, 5, 20)
  -- Ball
  love.graphics.rectangle("fill", ballX, ballY, 4, 4)
  push:apply('end')
end