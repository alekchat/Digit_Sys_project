`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2025 11:52:20 AM
// Design Name: 
// Module Name: UART_TX_top_module
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


module UART_TX_top_module(  input wire reset,
                            input wire clk,
                            input wire [1:0] baud_rate,
                            input wire [7:0] din,
                            input wire [1:0] parity_type,
                            input wire enable,
                            output wire sending,
                            output wire out);
    
    // Internal signal declarations
    wire baud_clk;
    wire parity_bit;
                            
    
    Baud_Gen uut1 (
                    .reset(reset),
                    .clk(clk),
                    .baud_rate(baud_rate),
                    .baud_clk(baud_clk)
                  ); 
                  
                  
    Parity_check uut2 (
                        .reset(reset),
                        .din(din),
                        .parity_type(parity_type),
                        .parity_bit(parity_bit)                           
                      );    
    
    
    uart_tx uut3 (
                    .baud_clk(baud_clk),
                    .din(din),
                    .enable(enable),
                    .reset(reset),
                    .sending(sending),
                    .out(out),
                    .parity_bit(parity_bit)                   
                 );        
endmodule
