-- Written by Rabia Alhaffar in 25/September/2020
-- Clipboard module for LÖVR

-- Load FFI and check support for lovr-clipboard
local osname = (lovr.getOS or lovr.system.getOS)()
local ffi = assert(type(jit) == "table" and   -- Only run if we have LuaJIT and also GLFW
  osname ~= "Android" and osname ~= "Web" and
  require("ffi"), "lovr-clipboard cannot run on this platform!")
local C = (osname ~= "Android" and osname ~= "Web") and ffi.load("glfw3") or ffi.C

ffi.cdef([[
typedef struct GLFWwindow GLFWwindow;
GLFWwindow* glfwGetCurrentContext(void);

const char* glfwGetClipboardString(GLFWwindow *window);
void glfwSetClipboardString(GLFWwindow *window, const char *string);
]])

local window = C.glfwGetCurrentContext()

---@class clipboardlib
---Clipboard module for LÖVR that leverages GLFW through LuaJIT's FFI, To use:
---```lua
---lovr.clipboard = require("lovr-clipboard")
---```
local clipboard = {}

---@version JIT
---Returns the last text copied to the Clipboard as string, Example:
---```lua
---local text = lovr.clipboard.get()
---```
---@return string
---@nodiscard
function clipboard.get()
  return ffi.string(C.glfwGetClipboardString(window))
end

---@version JIT
---Copies the string `str` to the Clipboard, Example:
---```lua
---lovr.clipboard.set("Hello, Clipboard!")
---```
---@param str string
function clipboard.set(str)
  C.glfwSetClipboardString(window, str)
end

---@version JIT
---Clears the clipboard, Example:
---```lua
---lovr.clipboard.clear()
---```
function clipboard.clear()
  C.glfwGetClipboardString(window, nil)
end

return clipboard
