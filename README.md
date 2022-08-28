# lovr-clipboard

Clipboard module for [LÖVR](https://lovr.org) that leverages [GLFW](https://glfw.org) through [LuaJIT's FFI](https://luajit.org/ext_ffi.html).

### Usage

```lua
-- Require the module so we can deal with the Clipboard.
lovr.clipboard = require("lovr-clipboard")

local text = nil

function lovr.load()  
  -- Copy text "Hello, Clipboard!" to the Clipboard.
  local success, error_code, error_message = lovr.clipboard.set("Hello, Clipboard!")
  
  -- If no error occurred then retrieve the text from the Clipboard as string.
  if success then
    text, error_code, error_message = lovr.clipboard.get()
  end
  
  -- If error occurred then set the text to the error message.
  if ((not success) or (text == nil)) then
    text = error_message
  end
end

function lovr.draw()
  -- Draws text copied to the Clipboard if success, Or draws the error message if error has occurred.
  lovr.graphics.print(text, 0, 0, -5, 0.5)
end
```

Check out the [API](https://github.com/Rabios/lovr-clipboard/blob/master/API.md) for more informations on using the library.

### Support and Troubleshooting

1. If LÖVR throws error due to missing procedure(s) then replace the shared library of GLFW (Which comes along LÖVR files) with the latest one from [GLFW Downloads](https://www.glfw.org/download.html)

2. As of the latest commit, The annotations for [Lua Language Server](https://github.com/sumneko/lua-language-server) is provided so it will help in case you are using [Visual Studio Code](https://code.visualstudio.com)

3. If you want to use `lovr-clipboard` outside of LÖVR within another Lua game engine/framework that leverages GLFW then it's possible, Keep in mind that you are calling the functions after initializing GLFW and without dereferencing via `lovr.`

### License

MIT, Check [`LICENSE.txt`](https://github.com/Rabios/lovr-clipboard/blob/master/LICENSE.txt) for the license.
