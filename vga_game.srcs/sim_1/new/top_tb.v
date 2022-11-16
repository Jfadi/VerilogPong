`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 06:38:49 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb();

wire vsync, hsync;
wire [3:0] R_out;
wire [3:0] G_out;
wire [3:0] B_out;
reg clk;


top uut(.clk(clk) , .quadA(1'b0) , .quadB(1'b0) , .reset(0) , .R(R_out) , .G(G_out) , .B(B_out), .hsync(hsync) , .vsync(vsync));

always #1 clk = ~clk;



initial begin
    clk = 0;
end
endmodule
