`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2025 04:32:06 PM
// Design Name: 
// Module Name: uart_rx
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


module uart_rx(input wire din,
                input wire baud_clk,
                input wire reset,
                output reg [7:0] out,
                output reg recieve_flag);
                
  parameter idle = 1'b0, recieve = 1'b1;
  reg [3:0] idx = 4'b0;
  reg current_state;
  reg [3:0] oversample_cnt = 4'b0;
  reg [9:0] frame = 0;
  parameter CLK_DIV = 1;
  parameter bit_cnt = 1; //CLK_DIV based on the baud rate prob an input wire of br to compute                                     //CLK_DIV
  
  always @ (posedge baud_clk or negedge reset)
    begin
      if(!reset) begin
        current_state <= idle;
        recieve_flag <= 0;
        out <= 0;
        idx <= 4'b0;
      end
      else begin
        case (current_state)
          idle: begin
            recieve_flag <=0;
            idx <= 4'b0;
            if(!din) begin
              current_state <= recieve;
              recieve_flag <= 1;
            end
          end
          recieve: begin
            if (oversample_cnt == 4'd7) begin
                if(idx == 9) begin
                    current_state <= idle;
                    recieve_flag <= 0;
                    idx <= 0;
                    out <= frame[8:1];
                end else begin
                    oversample_cnt <= 0;
                    frame[idx] <= din;
                    idx <= idx + 1;
                end
            end else begin
                oversample_cnt <= oversample_cnt + 1;
                end
            end
          default: begin
            current_state <= idle;
            end
          endcase 
       end
    end   
endmodule
