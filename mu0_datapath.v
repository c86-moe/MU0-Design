// MU0 datapath design - structural style
// P W Nutter (based on a design by Jeff Pepper)
// Date 20/8/2021
// 

// Do not touch the following line it is required for simulation 
`timescale 1ns/100ps

// for simulation purposes, do not delete
`default_nettype none

module mu0_datapath(input  wire        Clk,
                    input  wire        Reset,
                    input  wire [15:0] Data_in,
					input  wire        X_sel,
					input  wire        Y_sel,
					input  wire        Addr_sel,
					input  wire        PC_En,
					input  wire        IR_En,
					input  wire        Acc_En,
					input  wire [1:0]  M,
                    output wire [3:0]  F,			// top 4 bits of the instruction
                    output wire [11:0] Address,
                    output wire [15:0] Data_out,
                    output wire        N,
					output wire        Z);


// Define internal signals using names from the datapath schematic
wire [11:0]	PC;
wire [15:0]	Acc;
wire [15:0]	IR;
wire [15:0]	ALU;
wire [15:0]	X;
wire [15:0]	Y;

// Instantiate Datapath components

//MU0 registers
mu0_reg16 IRReg(Clk, Reset, IR_En, Data_in, IR);
mu0_reg16 ACCReg(Clk, Reset, Acc_En, ALU, Acc);
mu0_reg12 PCReg(Clk, Reset, PC_En, ALU[11:0], PC);

// MU0 multiplexors
mu0_mux16 YMux(Data_in, IR, Y_sel, Y);
mu0_mux16 XMux(Acc, {4'b000,PC[11:0]}, X_sel, X);
mu0_mux12 AddrMux(PC, IR[11:0], Addr_sel, Address);

// MU0 ALU
mu0_alu mu0_ALU(X, Y, M, ALU);

// MU0 Flag generation
mu0_flags FLAGS(Acc, N, Z);

// The following connects X and Data_out together, there's no need for you to do so
// use X iwhen defining your datapath structure
buf DOUTBuf[15:0] (Data_out, X);
// Buffer added F is op 4 bits of the instruction
buf FBuf[3:0] (F, IR[15:12]);

endmodule 
