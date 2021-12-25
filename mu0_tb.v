// MU0 testbench
// P W Nutter (based on a design by Jeff Pepper)
// Date 20/8/2021
// 

// Do not touch the following line it is required for simulation 
`timescale 1ns/100ps 

module mu0_tb();

// Define any internal connections

reg Clk;
reg Reset;
wire Halted;

wire Wr;
wire Rd;
wire [11:0] Address;
wire [15:0] Data_in;
wire [15:0] Data_out;

// mu0 as dut (device under test) and mu0_memory have been instantiated
// for you

mu0 dut(Clk, Reset, Data_in, Rd, Wr, Address, Data_out, Halted);
mu0_memory memory(Clk, Wr, Rd, Address, Data_out, Data_in);


// Perform a reset action of MU0
initial
begin
   Reset = 1;
   Clk = 1;
   #50 Clk = 0;
   Reset = 0;
   while (Halted == 0) begin
      #50 Clk = 1;
      #50 Clk = 0;
   end
   #100 $finish; // exit the simulation - could tie this to the Halted signal going high
end
 
// Save results as VCD file 
// Do not change
initial
 begin
  $dumpfile("mu0_tb_results.vcd");  // Save simulation waveforms in this file
  $dumpvars; // Capture all simulation waveforms
 end

endmodule 
