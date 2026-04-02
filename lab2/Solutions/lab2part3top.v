module lab2part3top (
    input  wire [8:0] SW,
    output wire [3:0] LEDG
);
    wire [3:0] SW8 = {4{SW[8]}}; // creates 4 copies
    assign LEDG = (~SW8 & SW[3:0]) | (SW8 & SW[7:4]);
endmodule
