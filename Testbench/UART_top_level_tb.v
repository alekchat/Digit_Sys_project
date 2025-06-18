`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2025 14:51:50
// Design Name: 
// Module Name: UART_top_level_tb
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


module UART_top_level_tb();

    reg reset;
    reg clk;
    reg [1:0] baud_rate;
    reg data_RX;
    reg [1:0] parity_type;
    reg bitstream_mem [10:0];
    reg enable;
    
    wire receive_flag;
    reg [7:0] data_TX;
    wire parity_bit_RX;
    wire sending; 
    wire out_TX;
    wire [7:0] out_RX;
    integer i; 
    
    
    
    UART_top_module uut (.reset(reset),
                            .clk(clk),
                            .baud_rate(baud_rate),
                            .data_TX(data_TX),
                            .data_RX(data_RX),
                            .parity_type(parity_type),
                            .enable(enable),
                            .sending(sending),
                            .out_TX(out_TX),
                            .recieve_flag(receive_flag),
                            .out_RX(out_RX),
                            .parity_bit_RX(parity_bit_RX));
     
                            
initial begin
    $readmemb("C:/Users/alex/Downloads/project_1/project_1.srcs/sim_1/new/bitstream.txt", bitstream_mem); 
//$readmemb("bitstream.txt", bitstream_mem); 
end
     
// Clock generation: 50MHz => 20ns period (half cycle 10ns)
initial begin
    clk = 0;
    forever #10 clk = ~clk;  // Toggle clock every 10ns
end   
       
  initial begin
    // Initialize
    reset = 0;
    enable = 0;
    data_TX = 8'hA5;;
    data_RX = 1;
    baud_rate = 2'b00; // 00 means 2400 BR => Symbol period = 416.667us, 01 means 4800 BR => Sp = 208.333us...
    parity_type = 2'b10;

    // Reset pulse
    #500;
    reset = 0;
    #500;
    reset = 1;  
    #83450;
    
    enable = 1;
    for(i = 0; i < 11; i = i + 1) begin
        #416667; // 2400 BR
        //#208333; // 4800 BR
        //#107167;  // 9800 BR
        //#52083; // 19200 BR
        data_RX = bitstream_mem[i];
        if(i==9)begin
            enable = 0;
            end
        end
    
    
    // Wait for transmission to finish
    #900000;
    $finish;
  end                     

endmodule
