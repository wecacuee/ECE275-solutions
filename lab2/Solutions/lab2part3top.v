module lab2part3top (input [8:0] SW, output [3:0] LEDG);

	assign LEDG[0] = (~SW[8] & SW[0]) | (SW[8] & SW[4]);
	assign LEDG[1] = (~SW[8] & SW[1]) | (SW[8] & SW[5]);
	assign LEDG[2] = (~SW[8] & SW[2]) | (SW[8] & SW[6]);
	assign LEDG[3] = (~SW[8] & SW[3]) | (SW[8] & SW[7]);
endmodule