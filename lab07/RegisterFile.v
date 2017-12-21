`timescale 1ns / 1ps
`default_nettype none
module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
	output [63:0] BusA, BusB;
	input [63:0] BusW;
	input [4:0] RA, RB, RW;
	input RegWr;
	input Clk;
	reg [63:0] registers [31:0];

assign #2 BusA = registers[RA]; //delayed 2 tics then register RA is sent to BusA
assign #2 BusB = registers[RB]; //delayed 2 tics then register RB is sent to BusB

always @(posedge Clk)
    begin
		registers[31] = 0; //register 31 is always 0
end

always @(negedge Clk)
	begin
		if (RW != 31 && RegWr) //works when register is not 31 because it would be 0
			registers[RW] <= #3 BusW;  //3 tics for writing the register file into BusW
end
endmodule 