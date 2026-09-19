## How it works

A purely combinational passthrough. Each of the first 7 dedicated input pins
(`ui_in[6:0]`) is wired straight to one segment of a 7-segment display
(`uo_out[6:0]`, segments A through G). The 8th input pin (`ui_in[7]`) drives
a standalone LED on `uo_out[7]`.

There's no clock-dependent behaviour: the outputs update immediately whenever
the inputs change.

## How to test

Wire 8 switches (or a logic analyzer / microcontroller driving the pins) to
`ui_in[7:0]`. Toggle them and confirm the corresponding bit appears on
`uo_out[7:0]`. The included cocotb testbench (`test/test.py`) sweeps a set of
bit patterns through `ui_in` and checks that `uo_out` matches exactly.

## External hardware

- 7-segment display (segments A-G on `uo_out[0]` through `uo_out[6]`)
- 1 LED on `uo_out[7]`
- 8 switches or a compatible input source on `ui_in[7:0]`

Add current-limiting resistors (~220-330 ohm) in series with each segment
and the LED.
