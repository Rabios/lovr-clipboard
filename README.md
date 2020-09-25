# lovr-clipboard

Clipboard module for LÖVR!

### Usage

```lua
-- Require module
lovr.clipboard = require("lovr-clipboard")

function lovr.load()
  lovr.clipboard.set("This text copied to clipboard")
end

function lovr.draw()
  lovr.graphics.print(lovr.clipboard.get(), 0, 0, -5, 0.5)
end
```

### API

- `lovr.clipboard.get()` Returns string contains last text copied to clipboard (Gets last text copied).
- `lovr.clipboard.set(str)` Copies string `str` to clipboard.

### License

Check [`LICENSE.txt`](https://github.com/Rabios/lovr-joystick/blob/master/LICENSE.txt) for license.
