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
	 output reg [6:0] seg,
	 output reg [3:0] an
	 );
	 
	 wire pause_out;
	 wire rst_out;
	 
	 wire clk_1hz;
	 wire clk_2hz;
	 wire clk_fast;
	 wire clk_blink;
	 
	 //debounce buttons
	 
	 debouncer pause_btn(
		.clk(clk),
		.btn(pause),
		.btn_out(pause_out)
	 );
	 
	 debouncer rst_btn(
		.clk(clk),
		.btn(rst),
		.btn_out(rst_out)
	 );
	 
	 
	// PAUSE
	// To make the pause button toggleable
	 
	 reg is_paused = 0;
	 
	 always @(posedge pause_out) begin
			is_paused <= ~is_paused;
	 end
	 
	 //initialize clocks
	 
	 clock_dividers divs(
		.clk_in(clk),
		.rst(rst_out),
		.clk_1hz(clk_1hz),
		.clk_2hz(clk_2hz),
		.clk_fast(clk_fast),
		.clk_blink(clk_blink)
	 );
	 
	 wire [3:0] sec_1s;
	 wire [3:0] sec_10s;
	 wire [3:0] min_1s;
	 wire [3:0] min_10s;	  
	 
	 counter count(
		.rst(rst_out),
		.pause(is_paused),
		.adj(adj),
		.sel(sel),
		.clk(clk),
		.clk_adj(clk_2hz),
		.sec_1s_out(sec_1s),
		.sec_10s_out(sec_10s),
		.min_1s_out(min_1s),
		.min_10s_out(min_10s)
	 );
	 
	 
	 // SEG DISPLAY
	
	 wire [6:0] seg_min_10s;
	 wire [6:0] seg_min_1s;
	 wire [6:0] seg_sec_10s;
	 wire [6:0] seg_sec_1s;
	 
	
	//seg display
	
	display sec1s(
		.number(sec_1s),
		.seg(seg_sec_1s)
	);
	
	display sec10s(
		.number(sec_10s),
		.seg(seg_sec_10s)
	);
	
	display min1s(
		.number(min_1s),
		.seg(seg_min_1s)
	);
	
	display min10s(
		.number(min_10s),
		.seg(seg_min_10s)
	);
	
	reg [1:0] an_count = 0;
	
	always @(posedge clk_fast) begin
		//ADJUST MODE
		if (adj) begin
			if (sel == 0) begin // blinking minutes
				if (an_count == 0) begin
					an <= 4'b0111;
					an_count <= an_count + 1;
					// Logic for blinking
					if (clk_blink) begin
						seg <= seg_min_10s;
					end
					else begin
						seg <= 7'b1111111; // OFF
					end
				end
				else if (an_count == 1) begin
					an <= 4'b1011;
					an_count <= an_count + 1;
					if (clk_blink) begin
						seg <= seg_min_1s;
					end
					else begin
						seg <= 7'b1111111; // OFF
					end
				end
				else if (an_count == 2) begin
					an <= 4'b1101;
					seg <= seg_sec_10s;
					an_count <= an_count + 1;
				end
				else begin // count is 3
					an <= 4'b1110;
					seg <= seg_sec_1s;
					an_count <= 0;
				end
			end
			else begin // blinking minutes (sel 0)
				if (an_count == 0) begin
					an <= 4'b0111;
					an_count <= an_count + 1;
					seg <= seg_min_10s;
				end
				else if (an_count == 1) begin
					an <= 4'b1011;
					seg <= seg_min_1s;
					an_count <= an_count + 1;
				end
				else if (an_count == 2) begin
					an <= 4'b1101;
					an_count <= an_count + 1;
					if (clk_blink) begin
						seg <= seg_sec_10s;
					end
					else begin
						seg <= 7'b1111111; // OFF
					end
				end
				else begin // count is 3
					an <= 4'b1110;
					an_count <= 0;
					if (clk_blink) begin
						seg <= seg_sec_1s;
					end
					else begin
						seg <= 7'b1111111; // OFF
					end
				end
			end
		end		
		
		// NORMAL INCREMENT
		else begin
			if (an_count == 0) begin
				an <= 4'b0111;
				an_count <= an_count + 1;
				seg <= seg_min_10s;
			end
			else if (an_count == 1) begin
				an <= 4'b1011;
				seg <= seg_min_1s;
				an_count <= an_count + 1;
			end
			else if (an_count == 2) begin
				an <= 4'b1101;
				seg <= seg_sec_10s;
				an_count <= an_count + 1;
			end
			else begin // count is 3
				an <= 4'b1110;
				seg <= seg_sec_1s;
				an_count <= 0;
			end
		end
	end
	

endmodule
