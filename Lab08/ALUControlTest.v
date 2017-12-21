`timescale 1ns / 1ps

// Honestly, I'm unsure why I keep getting these errors and I emailed Ye about office hours to get further help
`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define SUB 4'b0110
`define LDUR 4'b0010
`define CBZ 4'b0111

`define ANDFunc 11'b10001010000
`define ORRFunc 11'b10101010000
`define ADDFunc 11'b10001011000
`define SUBFunc 11'b11001011000
`define LDURFunc 11'bXXXXXXXXXXX
`define STURFunc 11'bXXXXXXXXXXX
`define CBZFunc 11'bXXXXXXXXXXX
`define STRLEN 32

module ALUControlTest;
		
	task passTest;
		input [3:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		input [8:0] passed;
	
		if(actualOut == expectedOut) 
		begin 
		$display ("%s passed", testType); passed = passed + 1;
		end
		else 
		$display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [8:0] passed;
		input [8:0] numTests;
		
		if(passed == numTests) begin 
		$display ("All tests passed");
		end
		
		else 
		$display("Some tests failed");
	endtask

	// Inputs
	reg [1:0] ALUop;
	reg [10:0] Opcode;
	reg [8:0] passed;

	// Outputs
	wire [3:0] ALUCtrl;

	// Instantiate the Unit Under Test (UUT)
	ALUControl uut (
		.ALUCtrl(ALUCtrl), 
		.ALUop(ALUop), 
		.Opcode(Opcode)
	);

	initial begin
		// Initialize Inputs
		ALUop = 0;
		Opcode = 0;
		passed = 0;

		//Test Case 1
		#2; {ALUop, Opcode} = {2'b00, `LDURFunc}; #10;
				passTest(ALUCtrl, 4'b0010, "Test case 1", passed);
		
		//Test Case 2
		#2; {ALUop, Opcode} = {2'b01, `CBZFunc}; #10;
				passTest(ALUCtrl, 4'b0111, "Test case 2", passed);
		
		//Test Case 3
		#2; {ALUop, Opcode} = {2'b10, `SUBFunc}; #10;
			passTest(ALUCtrl, 4'b0110, "Test case 3", passed);
		
		//Test Case 4
		#2; {ALUop, Opcode} = {2'b10, `ORRFunc}; #10;
			passTest(ALUCtrl, 4'b0001, "Test case 4", passed);
		
		//Test Case 5
		#2; {ALUop, Opcode} = {2'b10, `ANDFunc}; #10;
			passTest(ALUCtrl, 4'b0000, "Test case 5", passed);
		
		//Test Case 6
		#2; {ALUop, Opcode} = {2'b10, `ADDFunc}; #10;
			passTest(ALUCtrl, 4'b0010, "Test case 6", passed);
		
		//Test Case 7
		#2; {ALUop, Opcode} = {2'b10, `ORRFunc}; #10;
			passTest(ALUCtrl, 4'b0001, "Test case 7", passed);
		
		//Test Case 8
		#2; {ALUop, Opcode} = {2'b10, `ADDFunc}; #10;
			passTest(ALUCtrl, 4'b0010, "Test case 8", passed);
		
		//Test Case 9
		#2; {ALUop, Opcode} = {2'b10, `SUBFunc}; #10;
			passTest(ALUCtrl, 4'b0110, "Test case 9", passed);
		
		allPassed(passed, 9);

	end
      
endmodule

