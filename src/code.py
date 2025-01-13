import time
import board
import displayio
from adafruit_macropad import MacroPad
from layouts.default import DefaultLayout
from layouts.media import MediaLayout
from utils.state import StateManager
# Initialize the MacroPad
macropad = MacroPad()
display = macropad.display
# Initialize the state manager
state = StateManager()
state.current_layout = "default"
# Available layouts
layouts = {
    "default": DefaultLayout(macropad),
    "media": MediaLayout(macropad)
}
# Main loop
while True:
    # Get current layout
    current_layout = layouts[state.current_layout]
    # Handle key events
    key_event = macropad.keys.events.get()
    if key_event:
        current_layout.handle_key(key_event)
    # Handle encoder
    position = macropad.encoder
    if position:
        current_layout.handle_encoder(position)
    # Update display
    current_layout.update_display()
    # Small delay to prevent overwhelming the processor
    time.sleep(0.1)
