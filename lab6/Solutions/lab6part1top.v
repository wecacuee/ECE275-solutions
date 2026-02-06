module lab6part1top (
	input [9:0] SW,
	output [9:0] LEDG,
	output [6:0] HEX0_D,
	output [6:0] HEX1_D,
	output [6:0] HEX2_D
);
	wire [11:0] converted_BCD;
	convert_8bit_to_BCD c2bcd1 (SW[7:0], converted_BCD);
	BCD_Display(converted_BCD[3:0], HEX0_D);
	BCD_Display(converted_BCD[7:4], HEX1_D);
	BCD_Display(converted_BCD[11:8], HEX2_D);
endmodule

module shiftadd3(
	input [3:0] A,
	output [3:0] S
);
	assign S[0] = (~A[3]&~A[2]&~A[1]&A[0])|(~A[3]&~A[2]&A[1]&A[0])|(~A[3]&A[2]&A[1]&~A[0])|(A[3]&~A[2]&~A[1]&~A[0]);
	assign S[1] = (~A[3]&~A[2]&A[1]&~A[0])|(~A[3]&~A[2]&A[1]&A[0])|(~A[3]&A[2]&A[1]&A[0])|(A[3]&~A[2]&~A[1]&~A[0]);
	assign S[2] = (~A[3]&A[2]&~A[1]&~A[0])|(A[3]&~A[2]&~A[1]&A[0]);
	assign S[3] = (~A[3]&A[2]&~A[1]&A[0])|(~A[3]&A[2]&A[1]&~A[0])|(~A[3]&A[2]&A[1]&A[0])|(A[3]&~A[2]&~A[1]&~A[0])|(A[3]&~A[2]&~A[1]&A[0]);
endmodule

module BCD_Display(
	input [3:0] BCDValue,
	output [6:0] LED_Segment
);
	 assign LED_Segment[0] = ~(BCDValue[3]|BCDValue[1]|(BCDValue[2]&BCDValue[0])|((~BCDValue[2])&(~BCDValue[0])));
    assign LED_Segment[1] = ~((~BCDValue[2])|(~BCDValue[1])&(~BCDValue[0])|BCDValue[1]&BCDValue[0]);
    assign LED_Segment[2] = ~(BCDValue[2]|(~BCDValue[1])|BCDValue[0]);
    assign LED_Segment[3] = ~((~BCDValue[2])&(~BCDValue[0])|BCDValue[1]&(~BCDValue[0])|BCDValue[2]&(~BCDValue[1])&BCDValue[0]|(~BCDValue[2])&BCDValue[1]|BCDValue[3]);
    assign LED_Segment[4] = ~((~BCDValue[2])&(~BCDValue[0])|BCDValue[1]&(~BCDValue[0]));
    assign LED_Segment[5] = ~(BCDValue[3]|(~BCDValue[1])&(~BCDValue[0])|BCDValue[2]&(~BCDValue[1])|BCDValue[2]&(~BCDValue[0]));
    assign LED_Segment[6] = ~(BCDValue[3]|BCDValue[2]&(~BCDValue[1])|(~BCDValue[2])&BCDValue[1]|BCDValue[1]&(~BCDValue[0]));
endmodule

module convert_8bit_to_BCD(
	input [7:0] binary_value,
	output [11:0] BCDValues
);
	wire [2:0] sad12;
	wire sad14;
	wire sad24;
	wire [2:0] sad23;
	wire sad34;
	wire [2:0] sad35;
	wire [2:0] sad46;
	wire sad56;
	wire [2:0] sad57;
	assign BCDValues[11]=1'b0;
	assign BCDValues[10]=1'b0;
	shiftadd3 sadmod1 ({1'b0,binary_value[7:5]},{sad14, sad12});
	shiftadd3 sadmod2 ({sad12, binary_value[4]},{sad24, sad23});
	shiftadd3 sadmod3 ({sad23, binary_value[3]},{sad34, sad35});
	shiftadd3 sadmod4 ({1'b0, sad14, sad24, sad34},{BCDValues[9], sad46});
	shiftadd3 sadmod5 ({sad35, binary_value[2]},{sad56, sad57});
	shiftadd3 sadmod6 ({sad46, sad56},BCDValues[8:5]);
	shiftadd3 sadmod7 ({sad57, binary_value[1]},{BCDValues[4:1]});
	assign BCDValues[0] = binary_value[0];
endmodule