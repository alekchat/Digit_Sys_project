`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2025 12:08:31 PM
// Design Name: 
// Module Name: UART_TX_top_module_tb
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


module UART_TX_top_module_tb();

    reg reset;
    reg clk;
    reg [1:0] baud_rate;
    reg [7:0] din;
    reg [1:0] parity_type;
    reg enable;
    wire sending;
    wire out;
    
    
    
    UART_TX_top_module uut (
                                .reset(reset),
                                .clk(clk),
                                .baud_rate(baud_rate),
                                .enable(enable),
                                .din(din),
                                .parity_type(parity_type),
                                .sending(sending),
                                .out(out)
                             );
                             
// Clock generation: 50MHz => 20ns period (half cycle 10ns)
initial begin
    clk = 0;
    forever #20 clk = ~clk;  // Toggle clock every 10ns
end 



initial begin
    // Initialize signals

    reset = 1;
    enable = 0;
    din = 8'hA5;
    baud_rate = 2'b00; // 00 means 2400 BR(f=1200Hz) so we have periods of 1669.12/2=834.5 us
    parity_type = 2'b10;
    
    #200;
    reset = 0;  // Release reset
    #200;
    reset = 1;  // Release reset
    #200
    enable = 1;
    #100000;
    enable = 0;
    //reset = 0;

    // Wait for transmission to finish
    #13450000;    
    // Finish simulation
    $stop;
end
                            

endmodule
