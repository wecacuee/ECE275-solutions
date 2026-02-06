module lab4part1top(
    input [8:0] SW,
	 output [4:0] LEDG
);
	four_bit_adder fba1 (SW[4:1],SW[8:5],SW[0],LEDG[3:0],LEDG[4]);
	//full_adder a1 (SW[2],SW[1],SW[0],LEDG[0],LEDG[1]);
endmodule

module full_adder(
	input A,
	input B,
	input Cin,
	output S,
	output Cout
);
	assign S = (~B&~A&Cin)|(~B&A&~Cin)|(B&~A&~Cin)|(B&A&Cin);
	assign Cout = (~B&A&Cin)|(B&~A&Cin)|(B&A&~Cin)|(B&A&Cin);
endmodule

module four_bit_adder(
	input [3:0] A,
	input [3:0] B,
	input Cin,
	output [3:0] S,
	output Cout
);
	wire [2:0] intermediate_values;
	full_adder a1 (A[0],B[0],Cin,S[0],intermediate_values[0]);
	full_adder a2 (A[1],B[1],intermediate_values[0],S[1],intermediate_values[1]);
	full_adder a3 (A[2],B[2],intermediate_values[1],S[2],intermediate_values[2]);
	full_adder a4 (A[3],B[3],intermediate_values[2],S[3],Cout);
endmodule