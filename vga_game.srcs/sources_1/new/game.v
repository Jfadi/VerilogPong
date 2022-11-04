`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
//////////////////////////////////////////////////////////////////////////////////


module game(
    input clk_25,
    input [9:0] x,
    input [9:0] y,
    output [3:0] R,
    output [3:0] G,
    output [3:0] B,
    output reg [4:0] timer_out
    );

integer clock_cycles = 0;
reg [7:0] sec_counter = 0;

// adding seconds to the counter
always@(posedge clk_25) begin
     // make sure the user started the game
     if (clock_cycles == 25000000) begin
        clock_cycles <= 0;
        sec_counter = sec_counter + 1;
        end
    else begin
        clock_cycles <= clock_cycles + 1;
    end
end

always@(sec_counter) begin
    timer_out <= sec_counter;
end
endmodule
