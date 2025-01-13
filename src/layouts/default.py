from layouts.base import BaseLayout
class DefaultLayout(BaseLayout):
    def __init__(self, macropad):
        super().__init__(macropad)
        self.key_colors = [(255, 0, 0), (0, 255, 0), (0, 0, 255)] * 4  # RGB pattern
        self.init_pixels()
    def init_pixels(self):
        for i in range(12):
            self.pixels[i] = self.key_colors[i]
    def init_display(self):
        self.macropad.display.auto_refresh = False
        self.text_lines = self.macropad.display_text(title="Default Layout")
        self.text_lines.show()
    def handle_key(self, key_event):
        if key_event.pressed:
            key = key_event.key_number
            print(f"Key {key} pressed")
            # Flash the key when pressed
            original_color = self.pixels[key]
            self.pixels[key] = (255, 255, 255)
            time.sleep(0.1)
            self.pixels[key] = original_color
    def handle_encoder(self, position):
        print(f"Encoder position: {position}")
    def update_display(self):
        self.text_lines.lines[0].text = "Default Layout"
        self.text_lines.lines[1].text = f"Encoder: {self.macropad.encoder}"
        self.text_lines.show()
