UIBox = class "UIBox"

-- p: percent size
-- p_offset: offset in percent
-- min: minimum size in pixels
-- max: maximum size in pixels
function UIBox:init(args)
  local args = args or {}
  self.flow = "row"
  self.min, self.max = args.min, args.max
  self.size, self.offset = args.size or 1, args.offset or 0
  self.x, self.y, self.width, self.height = 0,0,0,0
  self.color = args.color or {1,1,1,0.1}
  self.parent = nil
  self.children = {}
end

function UIBox:setChildren(flow, ...)
  self.flow = flow
  local children = {...}
  for i=1, #children do
    children[i].parent = self
  end
  self.children = children
  return self
end

function UIBox:refresh()
  local function correct(limit, cx, cw, sx, sw)
    -- helper function for correcting by min or max (like justify space between flexbox css)
    local diff = limit - cw
    return cx + diff * ((sx-cx) / (sw-cw)), limit
  end
  if self.parent == nil then
    self.width, self.height = love.graphics.getWidth(), love.graphics.getHeight()
  end
  self:setChildren(self.flow, unpack(self.children))
  local children = self.children
  for i=1, #children do
    local child = children[i]
    if self.flow == "column" then
      child.x = self.x 
      child.width = self.width
      child.y = self.y + self.height * child.offset
      child.height = self.height * child.size
      if child.min ~= nil and child.min > child.height then 
        child.y, child.height = correct(child.min, child.y, child.height, self.y, self.height)
      elseif child.max ~= nil and child.max < child.height then
        child.y, child.height = correct(child.max, child.y, child.height, self.y, self.height)
      end
    else -- == "row"
      child.x = self.x + self.width * child.offset
      child.width = self.width * child.size
      child.y = self.y 
      child.height = self.height
      if child.min ~= nil and child.min > child.width then 
        child.x, child.width = correct(child.min, child.x, child.width, self.x, self.width)
      elseif child.max ~= nil and child.max < child.width then
        child.x, child.width = correct(child.max, child.x, child.width, self.x, self.width)
      end
    end
    self.children[i]:refresh()
  end
end

function UIBox:drawUI()
  if self.color then
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.radius, self.radius)
  end
  for i=1, #self.children do
    self.children[i]:drawUI()
  end
end
