`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2025 10:00:30 PM
// Design Name: 
// Module Name: Baud_Gen
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


module Baud_Gen(
                    input wire reset,
                    input wire clk,
                    input wire [1:0] baud_rate,
                    output reg baud_clk
                );
    reg [10:0] clk_tick;
    reg [10:0] final_val;
    // assuming that the clk freq = 50 MHz and we want the bellow baud rates
    // 50 MHz -> T = 20ns, div=clk/(BR*16) since we have x16 oversampling
    always @(*)
    begin
        case(baud_rate)
        0: final_val = 11'd651;   // BR = 2400
        1: final_val = 11'd326;    // BR = 4800
        2: final_val = 11'd163;    // BR = 9600
        3: final_val = 11'd81;    // BR = 19200
        default: final_val = 11'd0;
     endcase 
     end
     
     always @(negedge reset, posedge clk)
     begin
        if(!reset)
        begin
            clk_tick <= 11'd0;
            baud_clk <= 1'b0;
        end
        else
        begin
            if (clk_tick == final_val)
            begin
                clk_tick <= 11'b0;
                baud_clk <= ~baud_clk;
            end 
            else
            begin
                clk_tick <= clk_tick + 1'd1;
                baud_clk <= baud_clk;
            end 
        end 
    end 
    
   
    
    
    
endmodule
