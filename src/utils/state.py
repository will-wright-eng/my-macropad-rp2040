class StateManager:
    def __init__(self):
        self._current_layout = "default"
    @property
    def current_layout(self):
        return self._current_layout
    @current_layout.setter
    def current_layout(self, layout):
        if layout not in ["default", "media"]:
            raise ValueError(f"Invalid layout: {layout}")
        self._current_layout = layout
