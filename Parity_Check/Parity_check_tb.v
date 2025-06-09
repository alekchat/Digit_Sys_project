// Design Name: 
// Module Name: Parity_check_tb
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


module Parity_check_tb;

  reg reset;
  reg [7:0] data_in;
  reg [1:0] parity_type;
  wire parity_bit;

  // Instantiate the module
  Parity_check uut (
    .reset(reset),
    .data_in(data_in),
    .parity_type(parity_type),
    .parity_bit(parity_bit)
  );

  initial begin
    // Case 1: Reset = 0 -> parity_bit should be 1
    reset = 0; data_in = 8'b00000000; parity_type = 2'b01; #10;

    // Case 2: Odd parity with even number of 1s -> parity_bit = 1
    reset = 1; data_in = 8'b00000000; parity_type = 2'b01; #10;

    // Case 3: Odd parity with odd number of 1s -> parity_bit = 0
    data_in = 8'b00000001; parity_type = 2'b01; #10;

    // Case 4: Even parity with odd number of 1s -> parity_bit = 1
    data_in = 8'b00000001; parity_type = 2'b10; #10;

    // Case 5: Even parity with even number of 1s -> parity_bit = 0
    data_in = 8'b00000011; parity_type = 2'b10; #10;

    // Done
    $finish;
  end

endmodule
