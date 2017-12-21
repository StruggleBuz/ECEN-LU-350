`timescale 1ns / 1ps

`define STRLEN 32
module NextPClogicTest;

	task passTest;
		input [31:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		input [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input reg [7:0] passed;
		input reg [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask
	
	// Inputs
	reg [63:0] CurrentPC;
	reg [63:0] SignExtImm64;
	reg Branch;
	reg ALUZero;
	reg Uncondbranch;
	reg passed;

	// Outputs
	wire [63:0] NextPC;
	reg [63:0] ExpectedNextPC;
	// Instantiate the Unit Under Test (UUT)
	NextPClogic uut (
		.NextPC(NextPC), 
		.CurrentPC(CurrentPC), 
		.SignExtImm64(SignExtImm64), 
		.Branch(Branch), 
		.ALUZero(ALUZero), 
		.Uncondbranch(Uncondbranch)
	);
//expectedNext

	initial begin
		// Initialize Inputs
		CurrentPC = 0;
		SignExtImm64 = 0;
		Branch = 0;
		ALUZero = 0;
		Uncondbranch = 0;
		passed = 0;
		#10

		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, ExpectedNextPC} = {64'h10, 64'b0, 1'b0, 1'b0, 1'b0, 64'h14};
		#10
		passTest(NextPC, ExpectedNextPC, "Normal CurrentPC+4 advance", passed);
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, ExpectedNextPC} = {64'h10, 64'h2, 1'b1, 1'b1, 1'b0, 64'h18};
		#10
		passTest(NextPC, ExpectedNextPC, "Take Conditional Branch Test", passed);

		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, ExpectedNextPC} = {64'h10, 64'h3, 1'b1, 1'b0, 1'b0, 64'h14};
		#10
		passTest(NextPC, ExpectedNextPC, "Branch Conditional Back Not Taken", passed);
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, ExpectedNextPC} = {64'h10, 64'h4, 1'b0, 1'b0, 1'b1, 64'h20};
		#10
		passTest(NextPC, ExpectedNextPC, "Branch Unconditional Test", passed);
		
		allPassed(passed, 4);
	
		$finish;
	end
      
endmodule

