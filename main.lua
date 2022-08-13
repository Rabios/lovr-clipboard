lovr.clipboard = require("lovr-clipboard")

function lovr.load()
  lovr.clipboard.set("This text copied to clipboard")
end

function lovr.draw()
  lovr.graphics.print(lovr.clipboard.get(), 0, 0, -5, 0.5)
end
