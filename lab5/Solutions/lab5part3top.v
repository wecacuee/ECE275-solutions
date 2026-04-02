module lab5part3top(
	input [1:0] KEY,
	input [9:0] SW,
	output [9:0] LEDR
);

reg [31:0] summed_counter;
reg [9:0] summed_counter2;
wire [31:0] average_steps;
always @(posedge SW[0]) begin
	summed_counter2 = summed_counter2 + 1'b1;
	// summed_counter = ~summed_counter[0];
end
always @(negedge KEY[0]) begin
	summed_counter = summed_counter + 1'b1;
	// summed_counter = ~summed_counter[0];
end

assign average_steps = summed_counter / summed_counter2;
assign LEDR[9:0] = average_steps[9:0];
endmodule