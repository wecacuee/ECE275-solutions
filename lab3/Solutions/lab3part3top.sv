module lab3part3top(
    input [7:0] SW,
    output [6:0] HEX0,
    output [6:0] HEX1
);
    BCD_DisplayBehav uniquename (SW[7:4],HEX1);
    BCD_DisplayBehav uniquename2 (.BCDValue(SW[3:0]),
                             .LED_Segment(HEX0));
endmodule

module BCD_DisplayBehav(
    input [3:0] BCDValue,
    output [6:0] LED_Segment
);
// All behavioral verilog goes in always block.
// Instead of curly braces, Verlog uses begin-end 
// blocks.
always_comb begin 
  // (1) output = 0 indicates a lit segment.
  // (2) 7'b means 7 bit binary number.
  // (3) _ underscore is only used to separate 
  //     large numbers.
  // (4) 4'd means the following it is a 4 bit decimal.
  // (5) <= means non-blocking  assignment. The next
  //     statement will execute without waiting for 
  //     the previous one to execute.
  // (6) case (varable) matches number before 
  //     colon: if the matches is true the statement or 
  //     begin-end block after the colon:.
  // (7) if the case (variable) does not match anything 
  //     then the circut must behave what the default 
  //      blocks says.
    case (BCDValue)
        //                       gfe_dbca
        4'd0 : LED_Segment <= 7'b100_0000;    //  
        4'd1 : LED_Segment <= 7'b111_1001;    // ---0---
        4'd2 : LED_Segment <= 7'b010_0100;    // |     |
        4'd3 : LED_Segment <= 7'b011_0000;    // 5     1
        4'd4 : LED_Segment <= 7'b001_1001;    // |     |
        4'd5 : LED_Segment <= 7'b001_0010;    // ---6---
        4'd6 : LED_Segment <= 7'b000_0010;    // |     |
        4'd7 : LED_Segment <= 7'b111_1000;    // 4     2
        4'd8 : LED_Segment <= 7'b000_0000;    // |     |
        4'd9 : LED_Segment <= 7'b001_0000;    // ---3---
        default : LED_Segment <= 7'bxxx_xxxx; // x = don't care, z = floating
    endcase
end
endmodule