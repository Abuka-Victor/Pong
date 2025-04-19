push = require('push')
Class = require('class')
require('Paddle')
require('Ball')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WINDOW_WIDTH = 432
VIRTUAL_WINDOW_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest') -- This helps with the texteure filtering, 
  -- making it look pixelated since the goal is to make it look retro.

  math.randomseed(os.time()) -- This is used to seed the random number generator with the current time.
  love.window.setTitle("Pong")

  smallFont = love.graphics.newFont('font.ttf', 8)

  scoreFont = love.graphics.newFont("font.ttf", 32)

  push:setupScreen(VIRTUAL_WINDOW_WIDTH, VIRTUAL_WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = true,
    vsync = true
  })

  player_1_score = 0
  player_2_score = 0

  ball = Ball( VIRTUAL_WINDOW_WIDTH / 2 - 2,  VIRTUAL_WINDOW_HEIGHT / 2 - 2, 4, 4)
  player1 = Paddle(10, 30, 5, 20)
  player2 = Paddle(VIRTUAL_WINDOW_WIDTH - 10, VIRTUAL_WINDOW_HEIGHT - 50, 5, 20)

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
      ball:reset()
    end
  end
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.update(dt)
  -- Player 1 movement
  if love.keyboard.isDown("w") then
    player1.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown("s") then
    player1.dy = PADDLE_SPEED
  else
    player1.dy = 0
  end
  -- Player 2 movement
  if love.keyboard.isDown("up") then
    player2.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown("down") then
    player2.dy = PADDLE_SPEED
  else 
    player2.dy = 0
  end

  -- Ball movement
  if gameState == "play" then
    ball:update(dt)
    player1:update(dt)
    player2:update(dt)
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
  player1:render()
  -- Paddle 2
 player2:render()
  -- Ball
  ball:render()
  push:apply('end')
end