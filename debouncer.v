`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:41:49 02/14/2022 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(
    input clk,
	 input btn,
	 output btn_out
	 );
	 
reg btn_out = 0;

reg[15:0] count;

always @ (posedge clk) begin
	if (btn == 0) begin
		count <= 0;
		btn_out <= 0;
	end
	else begin
		count <= count + 1;
		if (count == 16'hffff) begin
			btn_out <= 1;
			count <=0;
		end
	end
end


endmodule
