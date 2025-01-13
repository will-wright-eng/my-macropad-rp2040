import board
import digitalio
import time

led = digitalio.DigitalInOut(board.LED)
led.direction = digitalio.Direction.OUTPUT

val = 5

while True:
	print("Hello, CircuitPython!")
	led.value = True
	time.sleep(val)
	led.value = False
	print("yo mama")
	time.sleep(val)