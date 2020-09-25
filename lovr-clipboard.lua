-- Written by Rabia Alhaffar in 25/September/2020
-- Clipboard module for LÖVR

-- Load FFI and check support for lovr-joystick
local ffi = assert(type(jit) == "table" and               -- Only run if we have LuaJIT
  lovr.getOS() ~= "Android" and lovr.getOS() ~= "Web" and -- and also GLFW
  require("ffi"), "lovr-joystick cannot run on this platform!")
local C = (lovr.getOS() ~= "Android" and lovr.getOS() ~= "Web") and ffi.load("glfw3") or ffi.C
local ffi_string = ffi.string  -- Cache ffi.string so it would be better for performance ;)

ffi.cdef([[
    typedef struct GLFWwindow GLFWwindow;
  
    GLFWwindow* glfwGetCurrentContext(void);
    const char* glfwGetClipboardString(GLFWwindow *window);
    void glfwSetClipboardString(GLFWwindow *window, const char *string);
]])

local window    = C.glfwGetCurrentContext()
local clipboard = {}

function clipboard.get()
  return ffi_string(C.glfwGetClipboardString(window))
end

function clipboard.set(str)
  C.glfwSetClipboardString(window, str)
end

return clipboard