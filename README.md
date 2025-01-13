# my-macropad-rp2040

## summary

my old keypad started acking up so I'm resurecting the Adafruit MacroPad RP2040 that I bought a while ago. the first thing I found is that I have no idea how to use it...

- [CircuitPython Workflow for Adafruit MacroPad RP2040 - Claude](https://claude.ai/chat/2a722a16-fe01-4148-8100-2ea50729d584)
- [will-wright-eng/my-macropad-rp2040](https://github.com/will-wright-eng/my-macropad-rp2040/tree/main?tab=readme-ov-file)
- [Adafruit MacroPad RP2040 Starter Kit - 3x4 Keys + Encoder + OLED [ADABOX019 Essentials] : ID 5128 : Adafruit Industries, Unique & fun DIY electronics and kits](https://www.adafruit.com/product/5128)
- [The CIRCUITPY Drive | Welcome to CircuitPython! | Adafruit Learning System](https://learn.adafruit.com/welcome-to-circuitpython/the-circuitpy-drive)
- [MacroPad RP2040 Download](https://circuitpython.org/board/adafruit_macropad_rp2040/)

## Setup Notes

- runs [CircuitPython] which is based on [MicroPython]
- [serial console on mac] -- ie the serial output from whatever python is running

```bash
ls /dev/tty.*
screen /dev/tty.usbmodem14101 115200
```

## pre-built projects
- [MACROPAD HotKeys] - by Phillip Burgess
- [Adafruit MacroPad RP2040] - By Kattni Rembor
	- [MacroPad CircuitPython Library]
- [MacroPad 2FA TOTP Authentication Friend] - By Carter Nelson
- [MacroPad Remote Procedure Calls over USB to Control Home Assistant] - By M. LeBlanc-Williams


[by Phillip Burgess]: https://learn.adafruit.com/macropad-hotkeys/project-code
[Adafruit MacroPad RP2040]: https://learn.adafruit.com/adafruit-macropad-rp2040/macropad-circuitpython-library
[MacroPad CircuitPython Library]: https://learn.adafruit.com/adafruit-macropad-rp2040/macropad-circuitpython-library
[MacroPad 2FA TOTP Authentication Friend]: https://learn.adafruit.com/macropad-2fa-totp-authentication-friend/project-code
[MacroPad Remote Procedure Calls over USB to Control Home Assistant]: https://learn.adafruit.com/macropad-remote-procedure-calls-over-usb-to-control-home-assistant/macropad-setup

## TODO
- `load to macropad` / `sync with macropad` script that copies certain directory into the proper Volume & directory on the macropad
	- create CLI for this?
	- check diff if already loaded (manage state)
	- one-directional flow or two? should edits only be made in the repo or is there an easy way to grab changes made in-volume
	- snapshot endpoint: replicates everything (to a new branch?)
	- marge snapshots endpoint: automatically create commits and/or PRs that compare against certain branches (???)

## link dump
- https://learn.adafruit.com/adafruit-macropad-rp2040
- https://www.adafruit.com/product/5128
- https://www.adafruit.com/category/1018
- https://config.qmk.fm/#/adafruit/macropad/LAYOUT


[CircuitPython]:https://github.com/adafruit/circuitpython
[MicroPython]:https://github.com/micropython/micropython
[serial console on mac]: https://learn.adafruit.com/welcome-to-circuitpython/advanced-serial-console-on-mac-and-linux
