`timescale 1ns / 1ps
`define STRLEN 24

module SignExtenderTest;
	reg [31:0] Inst;
	wire [63:0] extended_number;
	reg [63:0] expected_output;
	SignExtender uut(.BusImm(extended_number), .Inst(Inst));

	task passTest;
		input[63:0] actualOut, expectedOut;
		if(actualOut == expectedOut)
		    begin
		    	$display ("%0t passed", $time);
		end
		    else
		     begin
		    	$display ("%0t - failed: actualOut - %H and it should be %H", $time, actualOut, expectedOut);
		     end
	endtask
	
	initial 
	begin //tests two instances of a 32 bits number, the number and its inverse
		Inst = 0;
		expected_output = 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
		
		//#1 Inst = 32'b000101_01_0101_0101_0101_0101_0101_0101;
		#1 Inst = {6'b000101, 26'b01_0101_0101_0101_0101_0101_0101};
		expected_output = {{38{1'b0}}, 26'b01_0101_0101_0101_0101_0101_0101}; //expected output of B Type 38 0's and the last 26 bits of 01_0101_0101_0101_0101_0101_0101
		#1 passTest(extended_number, expected_output);
		
		//#1 Inst = 32'b100101_10_1010_1010_1010_1010_1010_1010;
		#1 Inst = {6'b100101, 26'b10_1010_1010_1010_1010_1010_1010};
		expected_output = {{38{1'b1}}, 26'b10_1010_1010_1010_1010_1010_1010}; //expected output of B type is 38 1's and 26 bits of 10_1010_1010_1010_1010_1010_1010
		#1 passTest(extended_number, expected_output);
		
		
    	//#1 Inst = 32'b111_1100_0000_0_1010_1010_00_0_0000_0_0000;
		#1 Inst = {11'b111_1100_0000, 9'b0_1010_1010, 2'b00, 5'b0_0000, 5'b0_0000};
		expected_output = {{55{1'b0}}, 9'b0_1010_1010}; //expected output of D type is 55 bits of 0's and 9 bits of 0_1010_1010
		#1 passTest(extended_number, expected_output);
		
		//#1 Inst = 32'b111_1100_0010_1_0101_0101_00_0_0000_0_0000;
		#1 Inst = {11'b111_1100_0010, 9'b1_0101_0101, 2'b00, 5'b00000, 5'b00000};
		expected_output = {{55{1'b1}}, 9'b1_0101_0101}; //expected output of D type is 55 bits of 1's and 9 bits of 1_0101_0101
		#1 passTest(extended_number, expected_output);
		
		
	    	//#1 Inst = 32'b0101_0100_010_0101_0101_0101_0101_0_0000;
    		#1 Inst = {8'b0101_0100, 19'b010_0101_0101_0101_0101, 5'b0_0000};
    		expected_output = {{45{1'b0}}, 19'b010_0101_0101_0101_0101}; //expected output of CB type is 45 bits of 0's and 19 bits of 010_0101_0101_0101_0101
    		#1 passTest(extended_number, expected_output);
    		
    		//#1 Inst = 32'b1011_0101_101_1010_1010_1010_1010_0_0000;
    		#1 Inst = {8'b1011_0101, 19'b101_1010_1010_1010_1010, 5'b0_0000};
    		expected_output = {{45{1'b1}}, 19'b101_1010_1010_1010_1010}; //expected output of CB type is 45 bits of 1's and 19 bits of 101_1010_1010_1010_1010
    		#1 passTest(extended_number, expected_output);
		
		$finish;
	end
		
endmodule
