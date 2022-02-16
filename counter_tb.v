`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:05:04 02/16/2022
// Design Name:   counter
// Module Name:   /home/ise/Desktop/Project3/counter_tb.v
// Project Name:  Project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_tb;

	// counter test
	reg rst;
	reg pause;
	reg adj;
	reg sel;
	reg clk;
	reg clk_adj;
	
	// Outputs
	wire [3:0] sec_1s_out;
	wire [3:0] sec_10s_out;
	wire [3:0] min_1s_out;
	wire [3:0] min_10s_out;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.rst(rst),
		.pause(pause),
		.adj(adj),
		.sel(sel),
		.clk(clk),
		.clk_adj(clk_adj),
		.sec_1s_out(sec_1s_out),
		.sec_10s_out(sec_10s_out),
		.min_1s_out(min_1s_out),
		.min_10s_out(min_10s_out)
	);

	
	initial begin
	// Initialize Inputs
	rst = 0;
	pause = 0;
	adj = 0;
	sel = 0;
	clk = 0;
	clk_adj = 0;
	
	// Wait 100 ns for global reset to finish
	#10000;
	adj = 1;
	#500;
	sel = 1;
	#1000;
	adj =0;
	sel = 0;
	#3000;
	pause = 1;
	#500;
	pause = 0;
	#500;
	rst = 1;
	#500;
	rst = 0;
	end
	
	initial begin
	#1;
		forever begin
			#1 clk_adj = ~clk_adj;
		end
	end
	
	always begin
		#2 clk = ~clk;
	end
	
     
endmodule

