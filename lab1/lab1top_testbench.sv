// Timescale sets the duration of one clock with precision
// Here 1ns is the duration of a single timestep and 1ps is the precision
`timescale 1ns / 1ps
module testbench ( );
    // Intialize a clock variable to keep track of time
    reg Clk;
    // Intialize a variable for switches using 10 bit binary notation.
    reg [9:0] SW = 10'b0;
    // Create wire for output LEDG
    wire [9:0] LEDG;

    // Connect the switch and LED to simulated module lab1top
    lab1top lt1 (SW, LEDG);

    // Intial block is executed when the circuit starts
    initial begin
        // After a delay of 5 timesteps set SW to the following value using 10 bit binary notation
        #5 SW <= 10'b00_0001_0001;
        // After another delay of 5 timesteps set SW to the following value 10 bit binary notation
        #5 SW <= 10'b01_0011_0001;
    end
endmodule