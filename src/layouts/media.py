from layouts.base import BaseLayout
class MediaLayout(BaseLayout):
    def __init__(self, macropad):
        super().__init__(macropad)
        self.key_colors = [(64, 0, 64)] * 12  # Purple theme
        self.init_pixels()
        self.volume = 50
    def init_pixels(self):
        for i in range(12):
            self.pixels[i] = self.key_colors[i]
    def init_display(self):
        self.macropad.display.auto_refresh = False
        self.text_lines = self.macropad.display_text(title="Media Controls")
        self.text_lines.show()
    def handle_key(self, key_event):
        if key_event.pressed:
            key = key_event.key_number
            if key == 0:  # Play/Pause
                self.macropad.keyboard.press(self.macropad.Keycode.PLAY_PAUSE)
                self.macropad.keyboard.release_all()
            elif key == 1:  # Previous
                self.macropad.keyboard.press(self.macropad.Keycode.PREVIOUS_TRACK)
                self.macropad.keyboard.release_all()
            elif key == 2:  # Next
                self.macropad.keyboard.press(self.macropad.Keycode.NEXT_TRACK)
                self.macropad.keyboard.release_all()
    def handle_encoder(self, position):
        # Use encoder for volume control
        self.volume = max(0, min(100, self.volume + position))
        if position > 0:
            self.macropad.consumer_control.send(
                self.macropad.ConsumerControlCode.VOLUME_INCREMENT
            )
        else:
            self.macropad.consumer_control.send(
                self.macropad.ConsumerControlCode.VOLUME_DECREMENT
            )
    def update_display(self):
        self.text_lines.lines[0].text = "Media Controls"
        self.text_lines.lines[1].text = f"Volume: {self.volume}%"
        self.text_lines.show()
