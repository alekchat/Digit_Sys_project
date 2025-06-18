`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2025 02:37:02 PM
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(input wire baud_clk,
               input wire [7:0] din,
               input wire enable,
               input wire reset,
               input wire parity_bit,
               output reg sending,
               output reg out
);
    
  reg current_state;
  parameter idle = 1'b0, send = 1'b1;
  reg [10:0] frame = 11'b0;
  reg [3:0] idx = 4'b0;
  reg [3:0] oversample_cnt = 4'b0; //Oversample counter for baud clk
  
  always @ (posedge baud_clk or negedge reset)
    begin
      if(!reset) begin
        current_state <= idle;
        sending <= 1'b0;
      	out <= 1'b1;
        idx <= 4'b0;
        oversample_cnt  <= 4'd0;
    	end else begin
      case (current_state)
        idle: begin
          sending <= 1'b0;
          out <= 1'b1;
          idx <= 4'b0;
          oversample_cnt  <= 4'd0;
          if(enable) begin
            frame <= {1'b1, parity_bit, din, 1'b0};
            sending <= 1'b1;
            current_state <= send;
          end
        end
        send: begin
          sending <= 1'b1;
          if(oversample_cnt == 4'd15) begin
            oversample_cnt <= 4'b0;
            if(idx == 11) begin
                current_state <= idle;
            end else begin
                out <= frame[idx];
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
