/*
 * Copyright (c) 2026 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_dipswitch_7seg (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // ui_in[6:0] -> DIP switches 1-7, mapped directly to 7-segment segments A-G
  // ui_in[7]   -> DIP switch 8, mapped to the "morse" LED output
  //
  // NOTE: this is a pure combinational passthrough, same behaviour as the
  // Arduino sketch's digitalWrite(seg, !digitalRead(pin)) lines, minus the
  // inversion. If your real DIP switches are wired active-low (closed = 0,
  // like INPUT_PULLUP on the Uno), invert here instead:
  //   assign uo_out[6:0] = ~ui_in[6:0];
  //   assign uo_out[7]   = ~ui_in[7];

  assign uo_out[6:0] = ui_in[6:0];  // segments A-G
  assign uo_out[7]   = ui_in[7];    // morse LED

  // All bidirectional IOs are unused here: configure as inputs, drive 0
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  // List all unused inputs to avoid unused-signal lint warnings
  wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule
