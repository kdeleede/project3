`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:08:20 02/14/2022 
// Design Name: 
// Module Name:    stopwatch 
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
module stopwatch(
    input clk,
	 input rst,
	 input pause,
	 input sel,
	 input adj,
	 output seg,
	 output an
	 );
	 
	 wire pause_out;
	 wire rst_out;
	 
	 wire clk_1Hz;
	 wire clk_2Hz;
	 wire clk_fast;
	 wire clk_blink;
	 
	 //debounce buttons
	 
	 debouncer(
		.clk(clk),
		.btn(pause),
		.btn_out(pause_out)
	 );
	 
	 debouncer(
		.clk(clk),
		.btn(rst),
		.btn_out(rst_out)
	 );
	 
	 //initialize different modules
	 
	 clock_dividers(
		
	 );
	 
	 
	 
			//divider

	// PAUSE
	 
	 reg pause = 0;
	 
	 always @(posedge pause) begin
			pause <= ~pause;
	 end
	 
	 wire [3:0] seg_min_10s;
	 wire [3:0] seg_min_1s;
	 wire [3:0] seg_sec_10s;
	 wire [3:0] seg_sec_10s;
	 
	 
	 
			// counter
			
	//seg display
	
	/*
	
	always @ (posedge clk_fast) begin
	
	cases:
	
	adjust on seconds (sel == 1, adj == 1)
	
	adjust on minutes (sel == 0, adj == 1)
	
	normal
	
	ex.
	
	reg [1:0] count; <- 4 seg sections
	
	
	always @(clk_fast)
	
	if(count == 0) begin
		an <= 4'b0111;
		seg <= seg_mins_10s;
		count <= count + 1;
	end
	else if (count == 1) begin
		an <= 4'b1011;
		seg <= seg_mins_1s;
		count <= count +1;
	else if (count == 2) begin
		an <= 4'b1101;
		seg <= seg_sec_10s;
		count <= count +1;
	else begin
		an <= 4'b1110;
		seg <= seg_sec_1s;
		count <= count +1;
	end
		
	*/
	
	

endmodule
