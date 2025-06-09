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
    reg [13:0] clk_tick;
    reg [13:0] final_val;
    
    always @(*)
    begin
        case(baud_rate)
        00: final_val = 14'd10174;
        01: final_val = 14'd5208;
        10: final_val = 14'd2604;
        11: final_val = 14'd1302;
        default: final_val = 14'd0;
     endcase 
     end
     
     always @(negedge reset, posedge clk)
     begin
        if(!reset)
        begin
            clk_tick <= 14'd0;
            baud_clk <= 1'b0;
        end
        else
        begin
            if (clk_tick == final_val)
            begin
                clk_tick <= 14'b0;
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
