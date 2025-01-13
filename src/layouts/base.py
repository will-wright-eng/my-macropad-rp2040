class BaseLayout:
    def __init__(self, macropad):
        self.macropad = macropad
        self.pixels = macropad.pixels
        self.display = macropad.display
        self.encoder_switch = macropad.encoder_switch
        self.init_display()
    def init_display(self):
        """Initialize the display for this layout"""
        raise NotImplementedError
    def handle_key(self, key_event):
        """Handle key press/release events"""
        raise NotImplementedError
    def handle_encoder(self, position):
        """Handle encoder rotation"""
        raise NotImplementedError
    def update_display(self):
        """Update the display content"""
        raise NotImplementedError
