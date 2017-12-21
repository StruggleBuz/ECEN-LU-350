`timescale 1ns / 1ps

`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define SUB 4'b0110
`define LDUR 4'b0010
`define CBZ 4'b0111

`define ANDFunc 8'b10001010
`define ORRFunc 8'b10101010
`define ADDFunc 8'b10001011
`define SUBFunc 8'b11001011
`define LDURFunc 8'bXXXXXXXX
`define STURFunc 8'bXXXXXXXX
`define CBZFunc 8'bXXXXXXXX
`define STRLEN 64

module ALUControl(ALUCtrl, ALUop, Opcode);
     input [1:0] ALUop;
     input [10:0] Opcode;
     output reg [3:0] ALUCtrl;
	
	always @(*) begin
		if (ALUop == 2'b10) begin
		case(Opcode)
					//using 8 bits due to 11 bits saying overloads
					11'b10001011000: ALUCtrl <= #2 4'b0010; //ADD
					11'b11001011000: ALUCtrl <= #2 4'b0110; //SUB
					11'b10001010000: ALUCtrl <= #2 4'b0000; //AND
					11'b10101010000: ALUCtrl <= #2 4'b0001; //OR
					default: ALUCtrl <= #2 4'bx;
				endcase
									end
			else if (ALUop == 2'b01) begin
					ALUCtrl <= #2 4'b0111;//CBZ
										 end
										  
			else if (ALUop == 2'b00) 
					//8'b10001011: 
					ALUCtrl <= #2 4'b0010; 
				end
endmodule
