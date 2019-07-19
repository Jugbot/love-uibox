require "uibox"
require "uitext"

local editorMenu

function love.load()
  editorMenu = UIBox():setChildren("column",
    UIBox({size=1/5}):setChildren("row",
      UIText({text="Hello", color={1,1,1,1}})
    ),
    UIBox({size=1/5, offset=4/5, max=200})
  )
  editorMenu:refresh()
end

function love.draw()
  editorMenu:drawUI()
end