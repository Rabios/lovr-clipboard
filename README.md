# lovr-clipboard

Clipboard module for LÖVR that leverages GLFW through LuaJIT's FFI.

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

### API

#### `lovr.clipboard.get()`

Returns the last text copied to the Clipboard as string in addition to error's code and message if error occurred, Example:

```lua
local txt, error_code, error_message = lovr.clipboard.get()

-- Prints last text copied to the Clipboard, Or print the error message if error occurred.
print((txt == nil) and error_message or txt)
```

#### `lovr.clipboard.set(text)`

Copies the string `str` to the Clipboard and returns `true` if copy was successful or `false` if not in addition to error's code and message if occurred, Example:

```lua
-- Copy text "Hello, Clipboard!" to the Clipboard.
local success, error_code, error_message = lovr.clipboard.set("Hello, Clipboard!")

-- Print the error's code and message if occurred.
if not success then
  print(error_code, error_message)
end
```

#### `lovr.clipboard.clear()`

Clears the Clipboard and returns `true` if clearing the Clipboard was successful or `false` if not in addition to error's code and message if occurred, Example:

```lua
-- Clear the Clipboard.
local success, error_code, error_message = lovr.clipboard.clear()

-- Print the error's code and message if occurred.
if not success then
  print(error_code, error_message)
end
```

#### `lovr.clipboard.errors`

Contains a list of the error codes for errors that might occur when calling one of `lovr.clipboard` functions.

```lua
-- No error has occurred.
lovr.clipboard.errors.NONE = 0

-- The function was called that must not be called unless GLFW is initialized. 
lovr.clipboard.errors.GLFW_UNINITIALIZED = 0x00010001

-- The contents of the Clipboard could not be converted to the requested format.
lovr.clipboard.errors.UNAVAILABLE_FORMAT = 0x00010009

-- platform-specific error occurred.
lovr.clipboard.errors.PLATFORM_SPECIFIC = 0x00010008
```

### License

MIT, Check [`LICENSE.txt`](https://github.com/Rabios/lovr-joystick/blob/master/LICENSE.txt) for the license.
