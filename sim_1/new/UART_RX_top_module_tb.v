`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2025 01:50:22 PM
// Design Name: 
// Module Name: UART_RX_top_module_tb
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


module UART_RX_top_module_tb();

    
    reg reset;
    reg clk;
    reg [1:0] baud_rate;
    reg  din;
    reg [1:0] parity_type;
    wire recieve_flag;
    wire [7:0] out;
    wire parity_bit;
    reg sending;
    
    UART_RX_top_module dut (
                                .reset(reset),
                                .clk(clk),
                                .baud_rate(baud_rate),
                                .din(din),
                                .parity_type(parity_type),
                                .recieve_flag(recieve_flag),
                                .out(out),
                                .parity_bit(parity_bit)
                            );
     
// Clock generation: 50MHz => 20ns period (half cycle 10ns)
initial begin
    clk = 0;
    forever #1 clk = ~clk;  // Toggle clock every 10ns
end     
       
  initial begin
    // Initialize
    reset = 0;
    din = 1;
    baud_rate = 2'b00; // 00 means 2400 BR(f=1200Hz) so we have periods of 1669.12/2=834.5 us
    parity_type = 2'b01;

    // Reset pulse
    #500;
    reset = 0;
    #500;
    reset = 1;
    
    #83450;
    din = 0;
    #8345;
    din = 1;
    #83450;

    
    // Wait for transmission to finish
    #800000;
    $finish;
  end       
       
       
                            
endmodule
