`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:37:31 02/14/2022 
// Design Name: 
// Module Name:    clock_dividers 
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
module clock_dividers(
	input clk_in,
	input rst,
	output reg clk_1hz,
	output reg clk_2hz,
	output reg clk_fast,
	output reg clk_blink
);

reg [31:0] count_1hz;
reg [31:0] count_2hz;
reg [31:0] count_fast;  // Currently: 200hz
reg [31:0] count_blink; // greater than 1hz: 3hz

// 100MHz: 100 000 000

// count needed for 1hz clock: 50 000 000
// count needed for 2hz clock: 25 000 000
// count needed for 200hz / fast clock: 250 000
// count needed for blink: 12 500 000



always @(posedge clk_in or posedge rst) begin
	if (rst) begin
		count_1hz <= 32'b0;
		clk_1hz <= 1'b0;
	end
	else if (count_1hz == 49999999) begin
		count_1hz <= 1'b0;
		clk_1hz <= ~clk_1hz;
	end
	else begin
		count_1hz <= count_1hz + 32'b1;
	end
end

always @(posedge clk_in or posedge rst) begin
	if (rst) begin
		count_2hz <= 0;
		clk_2hz <= 0;
	end
	else if (count_2hz == 24999999) begin
		count_2hz <= 0;
		clk_2hz <= ~clk_2hz;
	end
	else begin
		count_2hz <= count_2hz + 1;
	end
end

always @(posedge clk_in or posedge rst) begin
	if (rst) begin
		count_fast <= 0;
		clk_fast <= 0;
	end
	else if (count_fast == 249999) begin
		count_fast <= 0;
		clk_fast <= ~clk_fast;
	end
	else begin
		count_fast <= count_fast + 1;
	end
end

always @(posedge clk_in or posedge rst) begin
	if (rst) begin
		count_blink <= 0;
		clk_blink <= 0;
	end
	else if (count_blink == 12499999) begin
		count_blink <= 0;
		clk_blink <= ~clk_blink;
	end
	else begin
		count_blink <= count_blink + 1;
	end
end

endmodule
