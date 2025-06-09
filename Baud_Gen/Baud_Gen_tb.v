// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Baud_Gen_tb;

// Testbench signals
reg reset_n;
reg clock;
reg [1:0] baud_rate;
wire baud_clk;

// Instantiate the module under test (MUT)
Baud_Gen dut (
    .reset(reset_n),
    .clk(clock),
    .baud_rate(baud_rate),
    .baud_clk(baud_clk)
);

// Clock generation: 50MHz => 20ns period (half cycle 10ns)
initial begin
    clock = 0;
    forever #10 clock = ~clock;  // Toggle clock every 10ns
end

// Test sequence
initial begin
    // Initialize signals
    reset_n = 1;
    baud_rate = 2'b00;

    // Apply reset
    #50;
    reset_n = 0;  // Release reset
    #50;
    reset_n =1;  // Release reset

    // Test for BAUD24 (2400 baud)
    baud_rate = 2'b00;  // BAUD24
    #800_000;  // Wait for some time (300us)
    baud_rate = 2'b01;  // BAUD24
    #800_000;  // Wait for some time (300us)
    // Finish simulation
    $stop;
end

// Monitor output
//initial begin
  //  $monitor("Time = %0t | reset_n = %b | baud_rate = %b | baud_clk = %b", 
    //          $time, reset_n, baud_rate, baud_clk);
//end


endmodule
