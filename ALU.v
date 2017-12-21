`timescale 1ns / 1ps
`default_nettype none
`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define LSL 4'b0011
`define LSR 4'b0100
`define SUB 4'b0110
`define PassB 4'b0111

module ALU(BusW, BusA, BusB, ALUCtrl, Zero);

parameter n = 64;
output reg Zero;
output [n-1:0] BusW;
input [n-1:0] BusA, BusB;
input [3:0] ALUCtrl;
reg [n-1:0] BusW;

always @(*)
	begin
	case(ALUCtrl)
		`AND: begin
			BusW <= #20 BusA & BusB;   //#20 is the delay of 20 intervals
		end
		`OR: begin
			BusW <= #20 BusA | BusB;
		end
		`ADD: begin
			BusW <= #20 BusA + BusB;
		end
		`LSL: begin
			BusW <= #20 BusA << BusB;
		end
		`LSR: begin
			BusW <= #20 BusA >> BusB;
		end
		`SUB: begin
			BusW <= #20 BusA - BusB;
		end
		`PassB: begin
			BusW <= #20 BusB;
		end
	endcase
end

always @(BusW)
	begin
		  #1 Zero = ((BusW == 64'b0) ? 1'b1 : 1'b0);
	end
	//assign #1 Zero = ((BusW == 64'b0) ? 1'b1 : 1'b0);
endmodule
