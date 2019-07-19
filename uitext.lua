require "uibox"
UIText = UIBox:extend(class "UIText")

function UIText:init(args)
  local args = args or {}
  self.super.init(self, args)
  self.text = args.text or ""
  self.align = args.align or "center"
  self.font = args.font or love.graphics.getFont()
end

function UIText:drawUI()
  love.graphics.setColor(unpack(self.color))
  love.graphics.setFont(self.font)
  love.graphics.printf(self.text, math.floor(self.x), math.floor(self.y+self.height/2-self.font:getAscent()/2), self.width, self.align)--, r, sx, sy, ox, oy, kx, ky )
end
