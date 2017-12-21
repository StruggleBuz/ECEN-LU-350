`timescale 1ns / 1ps
`define STRLEN 32
module ALUTest_v;

	task passTest;
		input [64:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;
 
                // Here is one example test vector, testing the ADD instruction:
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h2}; #40; passTest({Zero, BusW}, 65'h0ABCD1234, "ADD 0x1234,0xABCD0000", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	
		
		//ADD function
		{BusA, BusB, ALUCtrl} = {64'h1, 64'h0, 4'h2}; #40; passTest({Zero, BusW}, 65'h1, "ADD1, 1, 0, 1", passed);
		{BusA, BusB, ALUCtrl} = {64'h1, 64'h2, 4'h2}; #40; passTest({Zero, BusW}, 65'h3, "ADD2, 2, 1, 3", passed);
		{BusA, BusB, ALUCtrl} = {64'h4500, 64'h1, 4'h2}; #40; passTest({Zero, BusW}, 65'h4501, "ADD3, 4500, 1, 4501", passed);

		//AND function
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h0, 4'h0}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "AND1, 0, 0, 0", passed);
		{BusA, BusB, ALUCtrl} = {64'h1, 64'h2, 4'h0}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "AND2", passed);
		{BusA, BusB, ALUCtrl} = {64'h2, 64'h3, 4'h0}; #40; passTest({Zero, BusW}, 65'h00000000000000002, "AND3", passed);

		//ORR function 
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h1, 4'h1}; #40; passTest({Zero, BusW}, 65'h1, "ORR1", passed);
		{BusA, BusB, ALUCtrl} = {64'h1, 64'h2, 4'h1}; #40; passTest({Zero, BusW}, 65'h3, "ORR2", passed);
		{BusA, BusB, ALUCtrl} = {64'h2, 64'h3, 4'h1}; #40; passTest({Zero, BusW}, 65'h3, "ORR3", passed);

		//SUB function
		{BusA, BusB, ALUCtrl} = {64'h1, 64'h0, 4'b0110}; #40; passTest({Zero, BusW}, 65'h1, "SUB1", passed);
		{BusA, BusB, ALUCtrl} = {64'h2, 64'h1, 4'b0110}; #40; passTest({Zero, BusW}, 65'h1, "SUB2", passed);
		{BusA, BusB, ALUCtrl} = {64'h3, 64'h2, 4'b0110}; #40; passTest({Zero, BusW}, 65'h1, "SUB3", passed);

		//PASS function
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h1, 4'h7}; #40; passTest({Zero, BusW}, {0,64'h1}, "PASS1", passed);
		{BusA, BusB, ALUCtrl} = {64'h2, 64'h5, 4'h7}; #40; passTest({Zero, BusW}, {0,64'h5}, "PASS2", passed);
		{BusA, BusB, ALUCtrl} = {64'h3, 64'h0, 4'h7}; #40; passTest({Zero, BusW}, {1,64'h0}, "PASS3", passed);

		//LSL function
		{BusA, BusB, ALUCtrl} = {64'hA, 64'h8, 4'h4}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "LSL1", passed);
		{BusA, BusB, ALUCtrl} = {64'h9, 64'h8, 4'h4}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "LSL2", passed);
		{BusA, BusB, ALUCtrl} = {64'h8, 64'h8, 4'h4}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "LSL3", passed);

		//LSR function
		{BusA, BusB, ALUCtrl} = {64'h1, 64'h8, 4'h3}; #40; passTest({Zero, BusW}, 65'h00000000000000100, "LSR1", passed);
		{BusA, BusB, ALUCtrl} = {64'h2, 64'h8, 4'h3}; #40; passTest({Zero, BusW}, 65'h00000000000000200, "LSR2", passed);
		{BusA, BusB, ALUCtrl} = {64'h3, 64'h8, 4'h3}; #40; passTest({Zero, BusW}, 65'h00000000000000300, "LSR3", passed);
		allPassed(passed, 22);
	end 
      
endmodule

