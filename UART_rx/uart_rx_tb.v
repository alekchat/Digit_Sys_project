`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2025 04:53:21 PM
// Design Name: 
// Module Name: uart_rx_tb
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


module uart_rx_tb();

  reg reset;
  wire recieve_flag;
  reg din;
  reg baud_clk;
  wire [7:0] out;
  
  uart_rx uut (
  .din(din),
  .baud_clk(baud_clk),
  .reset(reset),
  .out(out),
  .recieve_flag(recieve_flag));

// Simulated baud tick: 100ns period pulse
  initial baud_clk = 0;
  always begin
    #5 baud_clk = 1;
    #5 baud_clk = 0;
  end

  initial begin
    // Initialize
    reset = 0;
    din = 1;

    // Reset pulse
    #50;
    reset = 1;

    // Wait and send a byte
    #50;
    din = 0;
    #160;
    din = 0;
    #160;
    din = 1;
    #160;
    din = 1;
    #160;
    din = 0;
    #160;
    din = 1;
    #160;


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


