-- Written by Rabia Alhaffar in 25/September/2020
-- Clipboard module for LÖVR

-- Load FFI and check support for lovr-joystick
local osname_func = (lovr.getOS or lovr.system.getOS)
local osname = osname_func()
local ffi = assert(type(jit) == "table" and               -- Only run if we have LuaJIT
  osname ~= "Android" and osname ~= "Web" and -- and also GLFW
  require("ffi"), "lovr-joystick cannot run on this platform!")
local C = (osname ~= "Android" and osname ~= "Web") and ffi.load("glfw3") or ffi.C
local bor = require("bit").bor
local C_str = ffi.string

ffi.cdef([[
    typedef struct GLFWwindow GLFWwindow;
  
    GLFWwindow* glfwGetCurrentContext(void);
    const char* glfwGetClipboardString(GLFWwindow *window);
    void glfwSetClipboardString(GLFWwindow *window, const char *string);
]])

local window    = C.glfwGetCurrentContext()
local clipboard = {}

function clipboard.get()
  return C_str(C.glfwGetClipboardString(window))
end

function clipboard.set(str)
  C.glfwSetClipboardString(window, str)
end

return clipboard
