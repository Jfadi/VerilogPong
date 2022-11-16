`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CECS 361
// Engineers: 
//          - Omar Kanj Y Basha Zada 
//          - Fadi Jarray
//          - Minhanh Tran
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input quadA,
    input quadB,
    input reset,
    input [3:0] R_in,
    input [3:0] G_in,
    input [3:0] B_in,
    output [3:0] R,
    output [3:0] G,
    output [3:0] B,
    output [7:0] cathode,
    output [7:0] anode,
    output hsync,
    output vsync
    );

    // wires for intenal top connections
    wire clk_25_internal; 
    wire [4:0] score_internal;
    wire [3:0] R_internal; 
    wire [3:0] G_internal;
    wire [3:0] B_internal;
    wire [9:0] h_pos_internal;
    wire [9:0] v_pos_internal;

    // connection of instances
    game game_instance      (.clk_25(clk_25_internal), .R(R_internal), .G(G_internal), .B(B_internal), .x(h_pos_internal), .y(v_pos_internal), .score_out(score_internal), .quadA(quadA), .quadB(quadB));
    display display_instance(.clk_25(clk_25_internal), .R_in(R_internal), .G_in(G_internal), .B_in(B_internal), .R_out(R), .G_out(G), .B_out(B), .hsync(hsync), .vsync(vsync), .H_pos(h_pos_internal), .V_pos(v_pos_internal));
    clk_wiz_0 clock_div     (.clk_in1(clk),.reset(reset), .clk_out1(clk_25_internal));
    two_7seg seg_instance   (.clk_25(clk_25_internal), .in(score_internal), .cathode(cathode), .anode(anode));

endmodule
