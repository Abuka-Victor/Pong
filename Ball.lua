Ball = Class{}

function Ball:init(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height

  self.dx = math.random(2) == 1 and 100 or -100 -- randomly set the direction of the ball
  self.dy = math.random(-50, 50) -- randomly set the vertical direction of the ball
  
end

function Ball:reset()
  self.x = VIRTUAL_WINDOW_WIDTH / 2 - self.width / 2
  self.y = VIRTUAL_WINDOW_HEIGHT / 2 - self.height / 2
  self.dx = math.random(2) == 1 and 100 or -100
  self.dy = math.random(-50, 50) * 1.5
end 

function Ball:update(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
end

function  Ball:render()
  love.graphics.setColor(1, 1, 1, 1) -- Set color to white
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end