`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2025 14:37:03
// Design Name: 
// Module Name: UART_top_module
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


module UART_top_module(     input wire reset,
                            input wire clk,
                            input wire [1:0] baud_rate,
                            input wire [7:0] data_TX,
                            input wire data_RX,
                            input wire [1:0] parity_type,
                            input wire enable,
                            output wire sending,
                            output wire out_TX,
                            output wire recieve_flag,
                            output wire [7:0] out_RX,
                            output wire parity_bit_RX);

    // Internal signal declarations
    wire baud_clk;
    wire parity_bit_TX;
    
        Baud_Gen uut1 (
                        .reset(reset),
                        .clk(clk),
                        .baud_rate(baud_rate),
                        .baud_clk(baud_clk)
                       );
        
        
        Parity_check uutTX (
                            .reset(reset),
                            .din(data_TX),
                            .parity_type(parity_type),
                            .parity_bit(parity_bit_TX)                           
                           );
       
        Parity_check uutRX (
                            .reset(reset),
                            .din(out_RX),
                            .parity_type(parity_type),
                            .parity_bit(parity_bit_RX)                           
                           );                                    
        
        uart_tx uut4 (
                        .baud_clk(baud_clk),
                        .din(data_TX),
                        .enable(enable),
                        .reset(reset),
                        .sending(sending),
                        .out(out_TX),
                        .parity_bit(parity_bit_TX)                   
                      );
    
    uart_rx uut5 (
                    .baud_clk(baud_clk),
                    .din(data_RX),
                    .reset(reset),
                    .recieve_flag(recieve_flag),
                    .out(out_RX)          
                 );                      
                      
        
endmodule
