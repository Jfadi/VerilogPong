`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2022 05:49:53 PM
// Design Name: 
// Module Name: clock_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module game(
    input clk_25,
    input [9:0] x,
    input [9:0] y,
    output [3:0] R,
    output [3:0] G,
    output [3:0] B
    );

reg [24:0] one_sec_counter;
localparam one_sec = 25_000_000;

always@(clk_25) begin
    if (one_sec_counter == one_sec) begin
        // spawn a ball
    end

    one_sec_counter = one_sec_counter + 1;
end
endmodule
