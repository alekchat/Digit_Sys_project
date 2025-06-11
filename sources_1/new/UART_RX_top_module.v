`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2025 01:28:40 PM
// Design Name: 
// Module Name: UART_RX_top_module
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


module UART_RX_top_module(  input wire reset,
                            input wire clk,
                            input wire [1:0] baud_rate,
                            input wire din,
                            input wire [1:0] parity_type,
                            output wire recieve_flag,
                            output wire [7:0] out,
                            output wire parity_bit);


    // Internal signal declarations
    wire baud_clk;

        Baud_Gen uut1 (
                    .reset(reset),
                    .clk(clk),
                    .baud_rate(baud_rate),
                    .baud_clk(baud_clk)
                  ); 
                  
                  
    Parity_check uut2 (
                        .reset(reset),
                        .din(out),
                        .parity_type(parity_type),
                        .parity_bit(parity_bit)                           
                      );    
    
    
    uart_rx uut3 (
                    .baud_clk(baud_clk),
                    .din(din),
                    .reset(reset),
                    .recieve_flag(recieve_flag),
                    .out(out)          
                 ); 

                            
endmodule
