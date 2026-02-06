module lab3part2top(
    input [7:0] SW,
    output [6:0] HEX0,
	 output [6:0] HEX1
);
	BCD_Display display0 (SW[3:0], HEX0);
	BCD_Display display1 (SW[7:4], HEX1);
endmodule

module BCD_Display(
	input [3:0] BCDValue,
	output [6:0] LED_Segment
);
	 wire d3, d2, d1, d0; // Declares single bit wires
	 assign {d3, d2, d1, d0} = BCDValue[3:0]; // Breaks bits into into single bit variables
	 assign LED_Segment[0] = ~(d3 | d1 | (d2&d0) |((~d2)&(~d0)));
    assign LED_Segment[1] = ~((~d2) | (~d1)&(~d0) | d1&d0);
    assign LED_Segment[2] = ~(d2 | (~d1) | d0);
    assign LED_Segment[3] = ~( (~d2)&(~d0) | d1&(~d0) | d2&(~d1)&d0 | (~d2)&d1 | d3);
    assign LED_Segment[4] = ~( (~d2)&(~d0) | d1&(~d0));
    assign LED_Segment[5] = ~(d3 | (~d1)&(~d0) | d2&(~d1) | d2&(~d0));
    assign LED_Segment[6] = ~(d3 | d2&(~d1) |(~d2)&d1 | d1&(~d0));
endmodule