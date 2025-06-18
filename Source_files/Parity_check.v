`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2025 20:58:40
// Design Name: 
// Module Name: Parity_check
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


module Parity_check(
                    input wire reset,
                    input wire [7:0] din,
                    input wire [1:0] parity_type,
                    output reg parity_bit

    );
    
    always @(*)
    begin
        if(!reset) parity_bit = 1'b1;
        else
        begin
            case (parity_type)
            2'b01: parity_bit = ~^din;  //ODD PARITY: even number of 1s -> returns one, odd returns zero
            2'b10: parity_bit = ^din;  // EVEN PARITY: even number of 1s -> returns zero, odd returns one
            default: parity_bit = 1'b1;
            endcase
        end 
    end
    
    
endmodule