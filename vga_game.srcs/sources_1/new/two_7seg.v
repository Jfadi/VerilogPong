`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Omar Kanj Y Basha Zada
//////////////////////////////////////////////////////////////////////////////////

module two_7seg(
    input clk_25,
    input [4:0] in,
    output reg [7:0] cathode,
    output reg [7:0] anode
    );

    reg [15:0] cath_cases;
    reg state = 1'b0;
    
    reg [11:0] counter = 0;
    always@(posedge clk_25) begin
        if (counter == 2000) begin
            state = ~state;
            counter = 0;
        end
        counter = counter + 1;
    end
    always@(*) begin
        case(in)
            5'b00000 : cath_cases = 16'b00000011_00000011;    //0
            5'b00001 : cath_cases = 16'b00000011_10011111;    //1
            5'b00010 : cath_cases = 16'b00000011_00100101;
            5'b00011 : cath_cases = 16'b00000011_00001101;
            5'b00100 : cath_cases = 16'b00000011_10011001;
            5'b00101 : cath_cases = 16'b00000011_01001001;
            5'b00110 : cath_cases = 16'b00000011_01000001;
            5'b00111 : cath_cases = 16'b00000011_00011111;
            5'b01000 : cath_cases = 16'b00000011_00000001;
            5'b01001 : cath_cases = 16'b00000011_00001001;    //9
            5'b01010 : cath_cases = 16'b10011111_00000011;    //10
            5'b01011 : cath_cases = 16'b10011111_10011111;
            5'b01100 : cath_cases = 16'b10011111_00100101;
            5'b01101 : cath_cases = 16'b10011111_00001101;
            5'b01110 : cath_cases = 16'b10011111_10011001;
            5'b01111 : cath_cases = 16'b10011111_01001001;    // 15
            5'b10000 : cath_cases = 16'b10011111_01000001;    // 16
            5'b10001 : cath_cases = 16'b10011111_00011111;    // 17
            5'b10010 : cath_cases = 16'b10011111_00000001;
            5'b10011 : cath_cases = 16'b10011111_00001001;
            5'b10100 : cath_cases = 16'b00100101_00000011;    // 20
            5'b10101 : cath_cases = 16'b00100101_10011111;
            5'b10110 : cath_cases = 16'b00100101_00100101;
            5'b10111 : cath_cases = 16'b00100101_00001101;
            5'b11000 : cath_cases = 16'b00100101_10011001;
            5'b11001 : cath_cases = 16'b00100101_01001001;
            5'b11010 : cath_cases = 16'b00100101_01000001;
            5'b11011 : cath_cases = 16'b00100101_00011111;
            5'b11100 : cath_cases = 16'b00100101_00000001;
            5'b11101 : cath_cases = 16'b00100101_00001001;
            5'b11110 : cath_cases = 16'b00100101_00000011;
            default : cath_cases = 16'b11111111_11111111;
        endcase
        cathode = state ? cath_cases[7:0] : cath_cases[15:8];
        anode = state ? 8'b11111110 : 8'b11111101;
    end
endmodule
