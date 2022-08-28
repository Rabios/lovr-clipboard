# API

> Implementation Notes:
> 
> 1. If no error occurs, Then the `error_code` is zero and `error_message` is set to `nil`
>

### `lovr.clipboard.errors`

Contains the list of numerical codes for the errors that might occur when calling one of the Clipboard functions.

```lua
--- No error has occurred.
lovr.clipboard.errors.NONE = 0

--- The function was called that must not be called unless GLFW is initialized.
lovr.clipboard.errors.GLFW_UNINITIALIZED = 0x00010001

--- The contents of the Clipboard could not be converted to the requested format.
lovr.clipboard.errors.UNAVAILABLE_FORMAT = 0x00010009

--- platform-specific error occurred.
lovr.clipboard.errors.PLATFORM_SPECIFIC = 0x00010008
```

### `lovr.clipboard.get()`

Retrieves the last text copied to the Clipboard as string, Along with error's code and message if error occurred.

If error occurred or the Clipboard is empty, Then Clipboard text will be returned as `nil`

```lua
-- Retrieve the last text copied to the Clipboard as string.
local txt, error_code, error_message = lovr.clipboard.get()

-- Prints the last text copied to the Clipboard, Or the error message if error occurred.
print((error_message ~= nil) and error_message or txt)
```

### `lovr.clipboard.set(str)`

Copies the string `str` to the Clipboard and returns `true` if the copy have been done successfully or `false` if not, Along with error's code and message if occurred.

If you want to clear the Clipboard, Then pass `nil` (or empty string) or use `lovr.clipboard.clear()` instead.

```lua
-- Copy text "Hello, Clipboard!" to the Clipboard.
local success, error_code, error_message = lovr.clipboard.set("Hello, Clipboard!")

-- Print the error's code and message if occurred.
if not success then
  print(error_code, error_message)
end
```

### `lovr.clipboard.clear()`

Clears the Clipboard and returns `true` if clearing the Clipboard have been done successfully or `false` if not, Along with error's code and message if occurred.

```lua
-- Clear the Clipboard.
local success, error_code, error_message = lovr.clipboard.clear()

-- Print the error's code and message if occurred.
if not success then
  print(error_code, error_message)
end
```
