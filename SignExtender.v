`timescale 1ns / 1ps
module SignExtender(BusImm, Inst);
	output reg [63:0] BusImm; //outputs a 64 bit
	input [31:0] Inst; //input of 32 bits
	//input Ctrl;

	always @(*) begin
		if (Inst[31:26] == 6'b000101) //tests for B type with sign 0
			assign BusImm = {{38{1'b0}}, Inst[25:0]};
		else if (Inst[31:26] == 6'b100101) //tests for B type with sign 1
			assign BusImm = {{38{1'b1}}, Inst[25:0]};
			
		else if (Inst[31:21] == 11'b11111000000) //tests for D type with sign 0
			assign BusImm = {{56{1'b0}}, Inst[19:12]};
		else if (Inst[31:21] == 11'b11111000010) //tests for D type with sign 1
			assign BusImm = {{56{1'b1}}, Inst[19:12]};
			
		else if (Inst[31:24] == 8'b01010100) //tests for CB type with sign 0
			assign BusImm = {{45{1'b0}}, Inst[23:5]};
		else if (Inst[31:24] == 8'b10110101) //tests for CB type with sign 1
			assign BusImm = {{45{1'b1}}, Inst[23:5]};
			
	end
endmodule
	