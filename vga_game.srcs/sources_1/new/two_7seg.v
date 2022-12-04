`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Omar Kanj Y Basha Zada
//////////////////////////////////////////////////////////////////////////////////

module two_7seg(
        input clk_25,
        input [1:0] a, //switches (switch between states)
        input [4:0] in,
        output reg [7:0] cathode,
        output reg [7:0] anode
    );

    // messages
    reg clk_16khz = 1'b0;
    reg clk_1hz = 1'b0;
    reg [3:0] clickcount = 0; //reg to hold the count
    reg [11:0] counter_16khz = 0;
    reg [24:0] counter_1hz = 0;
    reg [7:0] fourth; //registers
    reg [7:0] third;
    reg [7:0] second;
    reg [7:0] first;
    reg [15:0] cath_cases;
    reg [3:0] sseg;
    reg [7:0] an_temp;
    reg [7:0] number_sseg;
    reg [7:0] sseg_temp;
    reg [2:0] position = 0;
    reg state;

    // Clocking (clock division)
    always@(posedge clk_25) begin
        if (counter_16khz == 2000) begin
            clk_16khz = ~clk_16khz;
            counter_16khz = 0;
        end
        if (counter_1hz == 25000000) begin
            clk_1hz = ~clk_1hz;
            counter_1hz = 0;
        end
        counter_1hz = counter_1hz + 1;
        counter_16khz = counter_16khz + 1;
    end
    always @(posedge clk_1hz)
    begin
        if(clickcount == 8)
            clickcount <= 0;
        else
            clickcount <= clickcount + 1;
    end

    // Score cases to 7seg
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
            5'b11110 : cath_cases = 16'b00001101_00000011;
            default : cath_cases = 16'b11111111_11111111;
        endcase
    end

    // 
    always @(clk_1hz) begin
        if(a[0] == 1) begin // Start/reset message
            case(clickcount)
                0:
                begin
                    fourth = 1; //r
                    third = 2; //e
                    second = 3;  //a
                    first = 4; //d
                end 
                1:
                begin
                    fourth = 2;//e
                    third = 3; //a
                    second = 4;  //d
                    first = 5;//y
                end 
                2:
                begin
                    fourth = 3;//a
                    third = 4;//d
                    second = 5;  //y
                    first = 6;//_
                end 
                3:
                begin
                    fourth = 4;//d
                    third = 5;//y
                    second = 6;  //_
                    first = 7;//s
                end
                4:
                begin
                    fourth = 5;//y
                    third = 6;//_
                    second = 7;  //s
                    first = 2;//e
                end 
                5:
                begin
                    fourth = 6;//_
                    third = 7;//s
                    second = 2;  //e
                    first = 8;//t
                end 
                6:
                begin
                    fourth = 7;//s
                    third = 2;//e
                    second = 8;  //t
                    first = 6;//_
                end 
                7:
                begin
                    fourth = 2;//e
                    third = 8;//t
                    second = 6;// _
                    first = 9;//g
                end
                8:
                begin
                    fourth = 8;//t
                    third = 6;// _
                    second = 9;  //g
                    first = 10;//o
                end 
            endcase
        end else if(a[1] == 1) begin // Game end message 
            case(clickcount)
                0:
                begin
                    fourth = 9; //G
                    third = 10; //O
                    second =10;  //O
                    first = 4; //D
                end 
                1:
                begin
                    fourth = 10;//O
                    third = 10; //O
                    second = 4;  //d
                    first = 6;//_
                end 
                2:
                begin
                    fourth = 10;//o
                    third = 4;//d
                    second = 6;  //_
                    first = 11;//j
                end 
                3:
                begin
                    fourth = 4;//d
                    third = 6;//_
                    second = 11;  //j
                    first = 10;//o
                end
                4:
                begin
                    fourth = 6;//_
                    third = 11;//j
                    second = 10; //o
                    first = 12;//b
                end
                5:
                begin
                    fourth = 11;//j
                    third = 10;//o
                    second = 12; //b
                    first = 6;//_
                end
                6:
                begin
                    fourth = 10;//o
                    third = 12;//b
                    second = 6;  //_
                    first = 6;//_
                end
                7:
                begin
                    fourth = 12;//b
                    third = 6;//_
                    second = 6;// _
                    first = 6;//_
                end
                8:
                begin
                    fourth = 6;//_
                    third = 6;// _
                    second = 6 ;  //_
                    first = 6;//_
                end 
            endcase
        end else begin // Score
            case(clickcount)
                0:
                begin
                    fourth = 6;
                    third = 6;
                    second = 6;
                    first = 13;
                end
                1:
                begin
                    fourth = 6;
                    third = 6;
                    second = 13;
                    first = 14;
                end
                2:
                begin
                    fourth = 6;
                    third = 13;
                    second = 14;
                    first = 10;
                end
                3:
                begin
                    fourth = 13;
                    third = 14;
                    second = 10;
                    first = 1;
                end 
                4:
                begin
                    fourth = 14;
                    third = 10;
                    second = 1;
                    first = 2;
                end
                5:
                begin
                    fourth = 10;
                    third = 1;
                    second = 2;
                    first = 6;
                end
                6:
                begin
                    fourth = 1;
                    third = 2;
                    second = 6;
                    first = 6;
                end
                7:
                begin
                    fourth = 2;
                    third = 6;
                    second = 6;
                    first = 6;
                end
                8:
                begin
                    fourth = 6;
                    third = 6;
                    second = 6;
                    first = 6;
                end
            endcase
        end
    end

    always@(posedge clk_16khz) begin
        position = position + 1;
    end

    always @(*) begin
        case(position)
            3'b000: begin
                sseg = fourth;
                an_temp = 8'b01111111;
            end
            3'b001: begin
                sseg = third;
                an_temp = 8'b10111111;
            end
            3'b010: begin
                sseg = second;
                an_temp =8'b11011111;
                end
            3'b011: begin
                sseg = first;
                an_temp = 8'b11101111;
            end
            3'b100: begin
                an_temp = 8'b11111111;
            end
            3'b101: begin
                an_temp = 8'b11111111;
            end
            3'b110: begin
                an_temp = 8'b11111101;
                number_sseg = cath_cases[15:8];
            end
            3'b111: begin
                an_temp = 8'b11111110;
                number_sseg = cath_cases[7:0];
            end
            default: begin
                an_temp = 8'b11111111;
            end
        endcase
    end

    always @(*) begin
        case(sseg)
            1: sseg_temp =     8'b11110101;     //R 1
            2: sseg_temp =     8'b01100001;     //E 2
            3: sseg_temp =     8'b00010001;     //A 3
            4: sseg_temp =     8'b10000101;     //D 4
            5: sseg_temp =     8'b10001001;     //Y 5
            6: sseg_temp =     8'b11111111;     //  6
            7: sseg_temp =     8'b01001001;     //S 7
            8: sseg_temp =     8'b11100001;     //T 8
            9: sseg_temp =     8'b01000011;     //G 9
            10: sseg_temp =    8'b11000101;     //O 10
            11: sseg_temp =    8'b10000111;     //J 11
            12: sseg_temp =    8'b11000001;     //B 12
            13: sseg_temp =    8'b01001001;     //S 13
            14: sseg_temp =    8'b01100011;     //C 14
            default: sseg_temp = 8'b11111111;
        endcase
        cathode = (position < 3'b100) ? sseg_temp : number_sseg;
        anode = an_temp;
    end
endmodule
