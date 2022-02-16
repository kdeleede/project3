`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:25:36 02/16/2022
// Design Name:   clock_dividers
// Module Name:   /home/ise/Desktop/Project3/test.v
// Project Name:  Project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock_dividers
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk_in;
	reg rst;

	// Outputs
	wire clk_1hz;
	wire clk_2hz;
	wire clk_fast;
	wire clk_blink;

	// Instantiate the Unit Under Test (UUT)
	clock_dividers uut (
		.clk_in(clk_in), 
		.rst(rst), 
		.clk_1hz(clk_1hz), 
		.clk_2hz(clk_2hz), 
		.clk_fast(clk_fast), 
		.clk_blink(clk_blink)
	);

	initial begin
		// Initialize Inputs
		clk_in = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		
        
		// Add stimulus here

	end
	
	always begin
		#1 clk_in = ~clk_in;
	end
      
endmodule

