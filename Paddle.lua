Paddle = Class{}

function Paddle:init(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.dy = 0 -- vertical speed
end

function Paddle:update(dt)
  if self.dy < 0 then
    self.y = math.max(0, self.y + self.dy * dt) -- Move up
  else
    self.y = math.min(VIRTUAL_WINDOW_HEIGHT - self.height, self.y + self.dy * dt) -- Move down
  end 
end

function Paddle:render()
  -- love.graphics.setColor(1, 1, 1, 1) -- Set color to white
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end