// MU0 12 bit register testbench
// P W Nutter (based on a design by Jeff Pepper)
// Date 20/8/2021
// 

// Do not touch the following line it is required for simulation 
`timescale 1ns/100ps 

// module header

module mu0_reg12_tb();

// Define any internal connections
reg   Clk;
reg   Reset;
reg   En;
reg   [11:0] D;
wire  [11:0] Q;

// Instantiate mu0_reg12 as dut (device under test)
mu0_reg12 dut(Clk, Reset, En, D, Q);

// Test vectors
initial
  begin
  D = 12'b0;
  Clk = 0;
  Reset = 0;
  En = 0;

  #100
  D = 12'h0AE;
  En = 1;
  #50
  Clk = 1;

  #50
  Clk = 0;
  En = 0;
  Reset = 1;
  #50
  Clk = 1;

  #50
  Clk = 0;
  D = 12'h8AE;
  En = 1;
  #50
  Clk = 1;

  #100 
  Clk = 0;
  $finish;      // end the simulation
end
 
// Save results as VCD file 
// Do not change
initial
 begin
  $dumpfile("mu0_reg12_tb_results.vcd");  // Save simulation waveforms in this file
  $dumpvars; // Capture all simulation waveforms
 end

endmodule 
