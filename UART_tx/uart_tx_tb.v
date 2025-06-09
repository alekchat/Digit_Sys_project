`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2025 02:40:26 PM
// Design Name: 
// Module Name: uart_tx_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_tx_tb();

  reg reset;
  reg enable;
  reg [7:0] din;
  reg baud_clk;
  wire sending;
  wire out;

  // Instantiate the module
  uart_tx uut (
    .baud_clk(baud_clk),
    .din(din),
    .enable(enable),
    .reset(reset),
    .sending(sending),
    .out(out)
  );

// Clock: 20ns period

  // Simulated baud tick: 100ns period pulse
  initial baud_clk = 0;
  always begin
    #5 baud_clk = 1;
    #5 baud_clk = 0;
  end

  initial begin
    // Initialize
    reset = 0;
    enable = 0;
    din = 8'hA5;

    // Reset pulse
    #25;
    reset = 1;

    // Wait and send a byte
    #50;
    enable = 1;
    #400;
    enable = 0;
    reset = 0;

    // Wait for transmission to finish
    #2000;
    $finish;
  end

  // VCD dump
  //initial begin
    //$dumpfile("uart.vcd");
    //$dumpvars(0, tb_uart);
  //end


endmodule
