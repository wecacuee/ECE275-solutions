module lab6part2top(
	input [9:0] SW,
	output [9:0] LEDG,
	input CLOCK,
	output [6:0] HEX0_D,
	output [6:0] HEX1_D,
	output [6:0] HEX2_D,
	output [6:0] HEX3_D,
	output HEX3_DP
);
wire [15:0] current_time;
wire [15:0] BCD_Value;
wire [15:0] difference;
timer_module(current_time, CLOCK, SW[0], SW[1]);
BCD_16_Bit_Converter somename (current_time, BCD_Value, CLOCK);
BCD_Display D1 (BCD_Value[3:0], HEX0_D);
BCD_Display D2 (BCD_Value[7:4], HEX1_D);
BCD_Display D3 (BCD_Value[11:8], HEX2_D);
BCD_Display D4 (BCD_Value[15:12], HEX3_D);

endmodule

module timer_module(
	output reg [13:0] milliseconds,
	input Clock_50MHz,
	input pause,
	input reset
);
reg [15:0] difference;
reg [15:0] timer_value;

always @ (posedge Clock_50MHz) begin
	if((reset == 0) && (pause == 0)) begin
		difference = milliseconds - 16'd9999;
		milliseconds = difference?milliseconds:16'b0;
		timer_value = timer_value + 1'b1;
		if(timer_value == 16'b1100001101010000) begin
			milliseconds = milliseconds+1;
			timer_value = 16'b0;
		end
	end
	else if (reset == 1)
		milliseconds = 0;
end
endmodule

module BCD_16_Bit_Converter(
	input [15:0] input_binary,
	output reg [15:0] output_BCD,
	input Clock_50MHz
);
	reg [4:0] i;
	
	always @(Clock_50MHz) begin
		output_BCD = 16'b0;
		for(i=0;i<16;i=i+1) begin
			output_BCD = {output_BCD[14:0],input_binary[15-i]};
			if(i<15 && output_BCD[3:0] > 4)
				output_BCD[3:0] = output_BCD[3:0] + 3;
			if(i<15 && output_BCD[7:4] > 4)
				output_BCD[7:4] = output_BCD[7:4] + 3;
			if(i<15 && output_BCD[11:8] > 4)
				output_BCD[11:8] = output_BCD[11:8] + 3;
			if(i<15 && output_BCD[15:12]>4)
				output_BCD[15:12] = output_BCD[15:12] + 3;
		end
	end
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