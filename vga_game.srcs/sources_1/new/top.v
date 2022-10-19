`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input reset,
    input [3:0] R_in,
    input [3:0] G_in,
    input [3:0] B_in,
    output [3:0] R,
    output [3:0] G,
    output [3:0] B,
    output hsync,
    output vsync
    );
    
    wire clk_25_internal;
    
    display dispaly_module(.clk_25(clk_25_internal), .R_in(R_in), .G_in(G_in), .B_in(B_in), .R_out(R), .G_out(G), .B_out(B), .hsync(hsync), .vsync(vsync));
    //clock_divider clk_divider_module(.clk(clk), .divided_clk(clk_25_internal));
    clk_wiz_0 clock_div(.clk_in1(clk),.reset(reset), .locked(1'b0), .clk_out1(clk_25_internal));

endmodule
