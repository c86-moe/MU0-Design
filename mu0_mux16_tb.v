// MU0 16 bit, 2 to 1 MUX testbench
// P W Nutter (based on a design by Jeff Pepper)
// Date 20/8/2021
// 

// Do not touch the following line it is required for simulation 
`timescale 1ns/100ps 

// module header

module mu0_mux16_tb();

// Define any internal connections
reg [15:0]  A;
reg [15:0]  B;
reg         S;
wire [15:0] Q;   


// Instantiate mu0_mux16 as dut (device under test)
mu0_mux16 dut(A, B, S, Q);


// Test vectors
initial
 begin
  A = 16'b0;
  B = 16'b0;
  S = 0;

  #100
  A = 16'h0BCD;
  B = 16'h0ABC;
  S = 1;

  #100
  S = 0;
  A = 16'hABCD;
  B = 16'h9ABC;

  #100;
  S = 1;
  
  #100
  B = 16'h9999;

  #100 $finish; // exit the simulation
end
 
// Save results as VCD file 
// Do not change
initial
 begin
  $dumpfile("mu0_mux16_tb_results.vcd");  // Save simulation waveforms in this file
  $dumpvars; // Capture all simulation waveforms
 end

endmodule 
