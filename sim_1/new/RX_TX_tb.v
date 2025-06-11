`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2025 02:38:01 PM
// Design Name: 
// Module Name: RX_TX_tb
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


module RX_TX_tb();


    reg reset;
    reg clk;
    reg [1:0] baud_rate;
    reg [7:0] data_in;
    reg [1:0] parity_type;
    reg enable;
    wire sending;
    wire tx_out;
    wire [7:0] data_out;
    wire parity_bit;
    wire recieve_flag;


    UART_TX_top_module dut1 (
                                .reset(reset),
                                .clk(clk),
                                .baud_rate(baud_rate),
                                .enable(enable),
                                .din(data_in),
                                .parity_type(parity_type),
                                .sending(sending),
                                .out(tx_out)
                             );
                             
                             
                             
    UART_RX_top_module dut2 (
                                .reset(reset),
                                .clk(clk),
                                .baud_rate(baud_rate),
                                .din(tx_out),
                                .parity_type(parity_type),
                                .recieve_flag(recieve_flag),
                                .out(data_out),
                                .parity_bit(parity_bit)
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
    data_in = 8'hA4;
    baud_rate = 2'b00; // 00 means 2400 BR(f=1200Hz) so we have periods of 1669.12/2=834.5 us
    parity_type = 2'b01;
    
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
    #52045000;    
    // Finish simulation
    $stop;
end

endmodule
