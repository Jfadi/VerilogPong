`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2022 03:49:52 PM
// Design Name: 
// Module Name: display_tb
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


module display_tb();

reg clk;

reg [3:0] R_in;
reg [3:0] G_in;
reg [3:0] B_in;


wire [3:0] R;
wire [3:0] G;
wire [3:0] B;
wire hsync, vsync;
wire [9:0] hcount;
wire [9:0] vcount;
always #1 clk = ~clk;

display uut(.clk_25(clk),.R_in(R_in) ,.G_in(G_in),.B_in(B_in),.R_out(R), .G_out(G), .B_out(B), .hsync(hsync), .vsync(vsync), .Hcount(hcount), .Vcount(vcount));

initial begin
    clk = 1;
    R_in = 4'b1111;
    G_in = 4'b0000;
    B_in = 4'b0000;
end
endmodule
