module lab4part1top(
    input  wire [8:0] SW,
	 output wire [4:0] LEDR
);
	four_bit_adder fba1 (SW[4:1],SW[8:5],SW[0],LEDR[3:0],LEDR[4]);
	//full_adder a1 (SW[2],SW[1],SW[0],LEDR[0],LEDR[1]);
endmodule

module full_adder(
	input  wire [0:0] A,
	input  wire [0:0] B,
	input  wire [0:0] Cin,
	output wire [0:0] S,
	output wire [0:0] Cout
);
	assign S 	= (~B & ~A & Cin) | (~B &  A & ~Cin) | (B & ~A & ~Cin)
						| (B & A & Cin);
	assign Cout = (~B &  A & Cin) | ( B & ~A &  Cin) | (B &  A & ~Cin)
						|(B & A & Cin);
endmodule

module four_bit_adder(
	input  [3:0] A,
	input  [3:0] B,
	input  [0:0] Cin,
	output [3:0] S,
	output [0:0] Cout
);
	wire [3:1] Cin_im;
	full_adder a1(A[0], B[0], 		  Cin, S[0], Cin_im[1]);
	full_adder a2(A[1], B[1], Cin_im[1], S[1], Cin_im[2]);
	full_adder a3(A[2], B[2], Cin_im[2], S[2], Cin_im[3]);
	full_adder a4(A[3], B[3], Cin_im[3], S[3], Cout);
endmodule