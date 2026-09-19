# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_dipswitch_passthrough(dut):
    dut._log.info("start")

    # Even though this design is combinational, TT always provides a clock
    # and reset, so we drive them the standard way.
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 5)

    dut._log.info("checking switch -> segment/LED passthrough")

    test_patterns = [0x00, 0x3F, 0xFF, 0x81, 0xA5, 0x01, 0x80]

    for pattern in test_patterns:
        dut.ui_in.value = pattern
        await ClockCycles(dut.clk, 2)
        assert dut.uo_out.value == pattern, (
            f"pattern {pattern:#04x}: expected uo_out={pattern:#04x}, "
            f"got {int(dut.uo_out.value):#04x}"
        )

    dut._log.info("all patterns passed")
