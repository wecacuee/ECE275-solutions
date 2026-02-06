module lab3part1top(
    input [3:0] SW,
    output [6:0] HEX0_D
);
	 wire [3:0] BCDValue;
	 wire [6:0] LED_Segment;
    assign BCDValue[3:0] = SW[3:0];
    assign HEX0_D[6:0] = LED_Segment[6:0];
    assign LED_Segment[0] = ~(BCDValue[3]|BCDValue[1]|(BCDValue[2]&BCDValue[0])|((~BCDValue[2])&(~BCDValue[0])));
    assign LED_Segment[1] = ~((~BCDValue[2])|(~BCDValue[1])&(~BCDValue[0])|BCDValue[1]&BCDValue[0]);
    assign LED_Segment[2] = ~(BCDValue[2]|(~BCDValue[1])|BCDValue[0]);
    assign LED_Segment[3] = ~((~BCDValue[2])&(~BCDValue[0])|BCDValue[1]&(~BCDValue[0])|BCDValue[2]&(~BCDValue[1])&BCDValue[0]|(~BCDValue[2])&BCDValue[1]|BCDValue[3]);
    assign LED_Segment[4] = ~((~BCDValue[2])&(~BCDValue[0])|BCDValue[1]&(~BCDValue[0]));
    assign LED_Segment[5] = ~(BCDValue[3]|(~BCDValue[1])&(~BCDValue[0])|BCDValue[2]&(~BCDValue[1])|BCDValue[2]&(~BCDValue[0]));
    assign LED_Segment[6] = ~(BCDValue[3]|BCDValue[2]&(~BCDValue[1])|(~BCDValue[2])&BCDValue[1]|BCDValue[1]&(~BCDValue[0]));
endmodule