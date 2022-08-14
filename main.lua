-- Require the module so we can deal with the Clipboard.
lovr.clipboard = require("lovr-clipboard")

function lovr.load()
  local text
  
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
