`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CECS 361
// Engineers: 
//          - Omar Kanj Y Basha Zada 
//          - Fadi Jarray
//          - Minhanh Tran
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
reg [9:0] ms_counter = 0; // can go between 0 -> 1000

// adding seconds to the counter
always@(posedge clk_25) begin
    // make sure the user started the game
    if (clock_cycles == 25000) begin
        ms_counter = ms_counter + 1;    // Should count up to 1000 and then reset
    end
    if (clock_cycles == 25000000) begin
        clock_cycles <= 0;
        ms_counter <= 0;
        sec_counter = sec_counter + 1;
    end
    else begin
        clock_cycles <= clock_cycles + 1;
    end
end

always@(sec_counter) begin
    timer_out <= sec_counter;
end

//  use the ms as the driver for the physics we are implementing for the balls
//  example
//  always@(ms_counter) begin
//      if(ms_counter%50 == 0) begin
//          // ALL LOGIC SHOULD BE HERE 
//          ball_x_pos = ball_x_pos + 50px;
//      end
//  end
//
//

endmodule
