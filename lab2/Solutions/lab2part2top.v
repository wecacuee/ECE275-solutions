module lab2part2top (
    input wire [2:0] SW,
    output wire [0:0] LEDG
);
	assign LEDG = (~SW[0] & SW[1]) | (SW[0] & SW[2]);
endmodule
