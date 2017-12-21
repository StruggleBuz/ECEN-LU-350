`timescale 1ns / 1ps
module DataMemory(ReadData, Address, WriteData,MemoryRead, MemoryWrite, Clock); 
    input [63:0] Address, WriteData; 
    input MemoryRead, MemoryWrite, Clock; 
    output [63:0] ReadData; 
		reg[63:0] Memory[63:0]; 
		reg[63:0] ReadData;

	always @(negedge Clock)begin //operates on the negative side of the clock cycle and writes
	/*if(MemoryWrite & (~MemoryRead)) begin
			Memory[(Address)] <= #20 WriteData;
		end
	end*/
		if(MemoryWrite) Memory[Address] <= #20 WriteData;
	end
	
	always @(posedge Clock) begin ////operates on the positive side of the clock cycle and reads
	/*if(MemoryRead & (~MemoryWrite)) begin
			temp <= #20 Memory[(Address)];
			end
			
		end*/
		if(MemoryRead) ReadData <= #20 Memory[Address];
			
	end
endmodule
