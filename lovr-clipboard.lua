-- Written by Rabia Alhaffar in 25/September/2020
-- Clipboard module for LÖVR

-- Load FFI and check support for lovr-clipboard
local osname = (lovr.getOS or lovr.system.getOS)()
local not_android_or_web = ((osname ~= "Android") and (osname ~= "Web"))

-- Only run if we have LuaJIT and also GLFW
local ffi = assert((type(jit) == "table") and not_android_or_web and
  require("ffi"), "lovr-clipboard cannot run on this platform!")

local C = (not_android_or_web and ffi.load("glfw3") or ffi.C)
local cstr = ffi.string

ffi.cdef([[
typedef struct GLFWwindow GLFWwindow;
GLFWwindow* glfwGetCurrentContext(void);

int glfwGetError(const char **description);

const char* glfwGetClipboardString(GLFWwindow *window);
void glfwSetClipboardString(GLFWwindow *window, const char *string);
]])

local window = C.glfwGetCurrentContext()

---
---@class clipboardlib
---
---Clipboard module for LÖVR that leverages GLFW through LuaJIT's FFI, To use:
---
---```lua
---lovr.clipboard = require("lovr-clipboard")
---```
---
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

---
---@version JIT
---
---Retrieves the GLFW error message and error code and used after calling GLFW function to check if success, This function is internal and not exposed for public usage.
---
---@return integer error_code The error code for the error message, Zero means no errors.
---@return string|nil error_message The error message, `nil` means no errors.
---
local function get_glfw_error()
  local error_message = nil
  local error_code = C.glfwGetError(error_message)
  
  return error_code, cstr(error_message)
end

---
---@version JIT
---
---Retrieves the last text copied to the Clipboard as string, Along with error's code and message if error occurred.
---
---@return string|nil text The last text from the Clipboard as string, `nil` if error occurred or the Clipboard is empty.
---@return integer error_code The error code for the error message, Zero means no errors.
---@return string|nil error_message The error message, `nil` means no errors.
---
---Example:
---
---```lua
----- Retrieve the last text copied to the Clipboard as string.
---local txt, error_code, error_message = lovr.clipboard.get()
---
----- Prints the last text copied to the Clipboard, Or the error message if error occurred.
---print((error_message ~= nil) and error_message or txt)
---```
---
function clipboard.get()
  local text = C.glfwGetClipboardString(window)
  
  return cstr(text), get_glfw_error()
end

---
---@version JIT
---
---Copies the string `str` to the Clipboard and returns if the copy have been done successfully or not, Along with error's code and message if occurred.
---
---@param text string|nil The string to copy to the Clipboard, Pass `nil` to clear the Clipboard. 
---@return boolean success `true` if the copy have been done successfully or `false` if not.
---@return integer error_code The error code for the error message, Zero means no errors.
---@return string|nil error_message The error message, `nil` means no errors.
---
---Example:
---
---```lua
----- Copy text "Hello, Clipboard!" to the Clipboard.
---local success, error_code, error_message = lovr.clipboard.set("Hello, Clipboard!")
---
----- Print the error's code and message if occurred.
---if not success then
---  print(error_code, error_message)
---end
---```
---
function clipboard.set(text)
  C.glfwSetClipboardString(window, text)
  local error_code, error_message = get_glfw_error()
  
  return (error_code == clipboard.errors.NONE), error_code, error_message
end

---
---@version JIT
---
---Clears the Clipboard and returns if clearing the Clipboard have been done successfully or not, Along with error's code and message if occurred.
---
---@return boolean success `true` if clearing the Clipboard have been done successfully or `false` if not.
---@return integer error_code The error code for the error message, Zero means no errors.
---@return string|nil error_message The error message, `nil` means no errors.
---
---Example:
---
---```lua
----- Clear the Clipboard.
---local success, error_code, error_message = lovr.clipboard.clear()
---
----- Print the error's code and message if occurred.
---if not success then
---  print(error_code, error_message)
---end
---```
---
function clipboard.clear()
  return clipboard.set(nil)
end

return clipboard
