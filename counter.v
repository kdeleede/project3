`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:26:51 02/14/2022 
// Design Name: 
// Module Name:    counter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module counter(
    input rst,
	 input pause,
	 input adj,
	 input sel,
	 input clk,     // 1Hz clock
	 input clk_adj, // 2Hz clock
	 output wire sec_1s_out,
	 output wire sec_10s_out,
	 output wire min_1s_out,
	 output wire min_10s_out
	 );
	 
	 reg [3:0] sec_1s = 0;
	 reg [3:0] sec_10s = 0;
	 reg [3:0] min_1s = 0;
	 reg [3:0] min_10s = 0;
	 
	 
	 //a clock that can be selected to be 1Hz or 2Hz
	 
	 reg clk_sel; // the selected clock
	 
	 always @* begin
		if (adj) begin
			clk_sel = clk;
		end
		else begin
			clk_sel = clk_adj;
		end
	 end
	 
	 //COUNTING IN CLOCK REGISTERS
	 
	 always @(posedge clk_sel or posedge rst) begin
		
		// On reset: Reset the clock components
		if (rst) begin
			sec_1s <= 0;
			sec_10s <= 0;
			min_1s <= 0;
			min_10s <= 0;
		end
		// On Pause: Do nothing
		else if (pause) begin
			// Empty
		end
		// On adjust: Use the 2hz clock and adjust what is selected(sel)
		else if (adj) begin
			if (sel) begin // sel == 1: adjusting seconds
				if (sec_10s == 5 && sec_1s == 9) begin
					sec_1s <= 0;
					sec_10s<= 0;
				end
				else if(sec_1s == 9) begin
					sec_1s <= 0;
					sec_10s<= sec_10s + 1;
				end
				// normal increment: sec
				else begin
					sec_1s <= sec_1s + 1;
				end
			end
			else begin //sel == 0: adjusting minutes
				if (min_10s == 5 && min_1s == 9) begin
					min_1s <= 0;
					min_10s<= 0;
				end
				else if(min_1s == 9) begin
					min_1s <= 0;
					min_10s<= min_10s + 1;
				end
				// normal increment: sec
				else begin
					min_1s <= sec_1s + 1;
				end
			end
		end
		// Default: Normal Increment mode
		else begin
			//increment min
			if (sec_10s == 5 && sec_1s == 9) begin
				sec_1s <= 0;
				sec_10s <= 0;
				//essentially a reset
				if (min_10s == 5 && min_1s == 9) begin
					min_1s <= 0;
					min_10s <= 0;
				end
				//increment min_10s
				else if (min_1s == 9) begin
					min_1s <= 0;
					min_10s<= min_10s + 1;
				end
				//normal increment: min
				else begin
					min_1s <= min_1s + 1;
				end
			end
			//increment sec_10s
			else if(sec_1s == 9) begin
				sec_1s <= 0;
				sec_10s<= sec_10s + 1;
			end
			// normal increment: sec
			else begin
				sec_1s <= sec_1s + 1;
			end
		end
	 end
	 

endmodule
