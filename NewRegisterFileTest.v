`timescale 1ns / 1ps


`define STRLEN 48
`define HALFCLKPERIOD 6
module NewRegisterFileTest_v;


	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%0t - %s failed: 0x%H should be 0x%H",$time, testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusW;
	reg [4:0] RA;
	reg [4:0] RB;
	reg [4:0] RW;
	reg RegWr;
	reg Clk;
	reg [7:0] passed;
	reg [7:0] numTests;
	
	// Outputs
	wire [63:0] BusA;
	wire [63:0] BusB;

	// Instantiate the Unit Under Test (UUT)
	RegisterFile uut (
		.BusA(BusA), 
		.BusB(BusB), 
		.BusW(BusW), 
		.RA(RA), 
		.RB(RB), 
		.RW(RW), 
		.RegWr(RegWr), 
		.Clk(Clk)
	);

	initial begin
		// Initialize Inputs
		BusW = 0;
		RA = 0;
		RB = 0;
		RW = 0;
		RegWr = 0;
		Clk = 1;
		#11;

		/* Run tests to make sure that X31 is 0 and stays 0 */
		{RA, RB, RW, BusW, RegWr} = {5'd31, 5'd31, 5'd31, 64'h0, 1'b0};
		#11; Clk = 0; #11; Clk = 1;
		passTest(BusA, 64'h0, "Initial $0 Check 1", passed);
		passTest(BusB, 64'h0, "Initial $0 Check 2", passed);
		
		#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd31, 5'd31, 5'd31, 64'h12345678, 1'b1};
		passTest(BusA, 64'h0, "Initial $0 Check 3", passed);
		passTest(BusB, 64'h0, "Initial $0 Check 4", passed);

		#11; Clk = 0; #11; Clk = 1;
		passTest(BusA, 64'h0, "$0 Stays 0 Check 1", passed);
		passTest(BusB, 64'h0, "$0 Stays 0 Check 2", passed);
		
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd0, 64'h0, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd1, 64'h1, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd2, 64'h2, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd3, 64'h3, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd4, 64'h4, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd5, 64'h5, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd6, 64'h6, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd7, 64'h7, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd8, 64'h8, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd9, 64'h9, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd10, 64'hA, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd11, 64'hB, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd12, 64'hC, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd13, 64'hD, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd14, 64'hE, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd15, 64'hF, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd16, 64'h10, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd17, 64'h11, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd18, 64'h12, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd19, 64'h13, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd20, 64'h14, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd21, 64'h15, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd22, 64'h16, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd23, 64'h17, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd24, 64'h18, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd25, 64'h19, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd26, 64'h1A, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd27, 64'h1B, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd28, 64'h1C, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd29, 64'h1D, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd30, 64'h1E, 1'b1};#11; Clk = 0; #11; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd31, 64'h1F, 1'b1};#11; Clk = 0; #11; Clk = 1;

		#11; Clk = 0; #11;
		//Using data provided in lab for test 1
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd1, 5'd0, 64'h0, 1'b0};
		Clk = 1; #11; Clk = 0; #11;
		passTest(BusA, 64'h0, "BusA updating X0", passed);
		passTest(BusB, 64'h1, "BusB updating X1", passed);

		//Using data provided in lab for test 2
		{RA, RB, RW, RegWr, BusW} ={5'd2, 5'd3, 5'd1, 1'b0, 64'h1000};
		Clk = 1; #11; Clk = 0; #11;
		passTest(BusA, 64'h2, "BusA updating X2", passed);
		passTest(BusB, 64'h3, "BusB updating X3", passed);
		
		{RA, RB, RW, RegWr, BusW} ={5'd4, 5'd5, 5'd0, 1'b1, 64'h1000};
		Clk = 1; #11; Clk = 0; #11;
		passTest(BusA, 64'h4, "BusA updating X4", passed);
		passTest(BusB, 64'h5, "WBusB updating X5", passed);
		
		{RA, RB, RW, RegWr, BusW} ={5'd4, 5'd5, 5'd0, 1'b1, 64'h1000};
		Clk = 1; #11; Clk = 0; #11;
		passTest(BusA, 64'h4, "BusA updating X4", passed);
		passTest(BusB, 64'h5, "BusB updating X5", passed);
		
		{RA, RB, RW, RegWr, BusW} ={5'd6, 5'd7, 5'ha, 1'b1, 64'h1010};
		Clk = 1; #11; Clk = 0; #11;
		passTest(BusA, 64'h6, "BusA updating X6", passed);
		passTest(BusB, 64'h7, "BusB updating X7", passed);

		{RA, RB, RW, RegWr, BusW} ={5'd8, 5'd9, 5'hb, 1'b1, 64'h103000};
		Clk = 1; #11; Clk = 0; #11;
		passTest(BusA, 64'h8, "BusA updating X8", passed);
		passTest(BusB, 64'h9, "BusB updating X9", passed);
		
		{RA, RB, RW, RegWr, BusW} ={5'hA, 5'hB, 5'hC, 1'b0, 64'h0};
		Clk = 1; #11; Clk = 0; #11;
		passTest(BusA, 64'h1010, "BusA updating XA", passed);
		passTest(BusB, 64'h103000, "BusB updating XB", passed);
		
		{RA, RB, RW, RegWr, BusW} ={5'hC, 5'hD, 5'hD, 1'b1, 64'hABCD};
		Clk = 1; #11; Clk = 0; #11;
		passTest(BusA, 64'hC, "BusA updating XC", passed);
		passTest(BusB, 64'hABCD, "BusB updating XD", passed);
		
		{RA, RB, RW, RegWr, BusW} ={5'hE, 5'hF, 5'hE, 1'b0, 64'h9080009};
		Clk = 1; #11; Clk = 0; #11;
		passTest(BusA, 64'hE, "BusA updating XE", passed);
		passTest(BusB, 64'hF, "BusB updating XF", passed);
		
	end
      
endmodule
