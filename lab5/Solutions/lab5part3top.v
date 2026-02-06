module lab5part3top(
	input [9:0] SW,
	output [9:0] LEDG,
	input CLOCK
);
reg [31:0] summed_counter;
always @ (posedge CLOCK) begin
	summed_counter = summed_counter + 1'b1;
end
assign LEDG[9:0] = summed_counter[31:23];

endmodule