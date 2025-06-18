`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2025 01:50:22 PM
// Design Name: 
// Module Name: UART_RX_top_module_tb
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


module UART_RX_top_module_tb();

    
    reg reset;
    reg clk;
    reg [1:0] baud_rate;
    reg  din;
    reg [1:0] parity_type;
    wire recieve_flag;
    wire [7:0] out;
    wire parity_bit;
    reg bitstream_mem [10:0];
    integer i;
    UART_RX_top_module dut (
                                .reset(reset),
                                .clk(clk),
                                .baud_rate(baud_rate),
                                .din(din),
                                .parity_type(parity_type),
                                .recieve_flag(recieve_flag),
                                .out(out),
                                .parity_bit(parity_bit)
                            );

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
    din = 1;
    baud_rate = 2'b11; // 00 means 2400 BR => Symbol period = 416.667us, 01 means 4800 BR => Sp = 208.333us...
    parity_type = 2'b10;

    // Reset pulse
    #500;
    reset = 0;
    #500;
    reset = 1;  
    #83450;
    
    for(i = 0; i < 11; i = i + 1) begin
        //#416667; // 2400 BR
        //#208333; // 4800 BR
        //#107167;  // 9800 BR
        #52083; // 19200 BR
        din = bitstream_mem[i];
        end

    
    // Wait for transmission to finish
    #900000;
    $finish;
  end       
       
       
                            
endmodule
