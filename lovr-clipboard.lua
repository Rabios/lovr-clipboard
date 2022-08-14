-- Written by Rabia Alhaffar in 25/September/2020
-- Clipboard module for LÖVR

-- Load FFI and check support for lovr-clipboard
local osname = (lovr.getOS or lovr.system.getOS)()
local ffi = assert(type(jit) == "table" and   -- Only run if we have LuaJIT and also GLFW
  osname ~= "Android" and osname ~= "Web" and
  require("ffi"), "lovr-clipboard cannot run on this platform!")
local C = (osname ~= "Android" and osname ~= "Web") and ffi.load("glfw3") or ffi.C
local cstr = ffi.string

ffi.cdef([[
typedef struct GLFWwindow GLFWwindow;
GLFWwindow* glfwGetCurrentContext(void);
int glfwGetError(const char **description);

const char* glfwGetClipboardString(GLFWwindow *window);
void glfwSetClipboardString(GLFWwindow *window, const char *string);
]])

local window = C.glfwGetCurrentContext()

---@class clipboardlib
---Clipboard module for LÖVR that leverages GLFW through LuaJIT's FFI, To use:
---```lua
---lovr.clipboard = require("lovr-clipboard")
---```
local clipboard = {
  --- Errors that might occur when calling one of the Clipboard functions.
  errors = {
    --- No error has occurred.
    NONE = 0,

    --- The function was called that must not be called unless GLFW is initialized.
    GLFW_UNINITIALIZED = 0x00010001,
    
    --- The contents of the Clipboard could not be converted to the requested format.
    UNAVAILABLE_FORMAT = 0x00010009,
    
    --- platform-specific error occurred.
    PLATFORM_SPECIFIC = 0x00010008
  }
}

---@version JIT
---Returns the last text copied to the Clipboard as string in addition to error's code and message if error occurred, Example:
---```lua
---local txt, error_code, error_message = lovr.clipboard.get()
---
----- Prints last text copied to the Clipboard, Or print the error message if error occurred.
---print((txt == nil) and error_message or txt)
---```
---@return string|nil text
---@return integer error_code
---@return string|nil error_message
function clipboard.get()
  local text, error_message = C.glfwGetClipboardString(window), nil
  local error_code = C.glfwGetError(error_message)

  return cstr(text), error_code, cstr(error_message)
end

---@version JIT
---Copies the string `str` to the Clipboard and returns `true` if copy was successful or `false` if not in addition to error's code and message if occurred, Example:
---```lua
----- Copy text "Hello, Clipboard!" to the Clipboard.
---local success, error_code, error_message = lovr.clipboard.set("Hello, Clipboard!")
---
----- Print the error's code and message if occurred.
---if not success then
---  print(error_code, error_message)
---end
---```
---@param text string|nil
---@return boolean success
---@return integer error_code
---@return string|nil error_message
function clipboard.set(text)
  local error_message = nil
  C.glfwSetClipboardString(window, text)

  local error_code = C.glfwGetError(error_message)

  return (error_code == clipboard.errors.NONE), error_code, cstr(error_message)
end

---@version JIT
---Clears the Clipboard and returns `true` if clearing the Clipboard was successful or `false` if not in addition to error's code and message if occurred, Example:
---```lua
----- Clear the Clipboard.
---local success, error_code, error_message = lovr.clipboard.clear()
---
----- Print the error's code and message if occurred.
---if not success then
---  print(error_code, error_message)
---end
---```
---@return boolean success
---@return integer error_code
---@return string|nil error_message
function clipboard.clear()
  return clipboard.set(nil)
end

return clipboard
