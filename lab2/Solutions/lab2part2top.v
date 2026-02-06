module lab2part2top (input [2:0] SW, output LEDG);
	assign LEDG = (~SW[0] & SW[1]) | (SW[0] & SW[2]);
endmodule