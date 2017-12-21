`timescale 1ns / 1ps
module NextPClogic (NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch ) ;
	input [63:0] CurrentPC , SignExtImm64;
	input Branch , ALUZero , Uncondbranch;
	output reg [63:0] NextPC;
	
	reg [63:0] NextPCNormal, NextPCBranch, SignExtShiftImm64;
	reg and0;
	
		always @(*)begin
			#2 SignExtShiftImm64 = SignExtImm64 << 2; //logic shift left by 2 operations
			
				NextPCNormal = CurrentPC + 4; // adds PC
				
				#2 NextPCBranch = CurrentPC + SignExtShiftImm64;//branch PC add
				
				and0 = Branch && ALUZero;//parallel AND statement
				
				#1 NextPC = (and0 || Uncondbranch) ? NextPCBranch : NextPCNormal;//MUX but this part does not work for some reason, emailed Ye for help
		end

endmodule 
