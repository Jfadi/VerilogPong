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
    input ACL_MISO, 
    input reset,
    input [3:0] R_in,
    input [3:0] G_in,
    input [3:0] B_in,
    output [3:0] R,
    output [3:0] G,
    output [3:0] B,
    output [7:0] cathode,
    output [7:0] anode,
    output ACL_MOSI,            // master out
    output ACL_SCLK,            // spi sclk
    output ACL_CSN, 
    output hsync,
    output vsync
    );

    // wires for intenal top connections
    wire clk_25_internal; 
    wire [4:0] score_internal;
    wire [3:0] R_internal; 
    wire [3:0] G_internal;
    wire [3:0] B_internal;
    wire y;
    wire y_cord_internal;
    wire integer h_pos_internal, v_pos_internal;

    // instanciation of modules
        game game_instance      (.clk_25(clk_25_internal), .R(R_internal), .G(G_internal), .B(B_internal), .x(h_pos_internal), .y(v_pos_internal), .y_cord(y_cord_internal) , .timer_out(timer_internal), .quadA(quadA), .quadB(quadB), .y_sign(y));
        display display_instance(.clk_25(clk_25_internal), .R_in(R_internal), .G_in(G_internal), .B_in(B_internal), .R_out(R), .G_out(G), .B_out(B), .hsync(hsync), .vsync(vsync), .H_pos(h_pos_internal), .V_pos(v_pos_internal));
        clk_wiz_1 clock_div     (.clk_in1(clk),.reset(reset), .locked(1'b0),.clk_out1(clk_100) ,.clk_out2(clk_25_internal));
        two_7seg seg_instance   (.clk_25(clk_25_internal), .in(timer_internal), .cathode(cathode), .anode(anode));

    // accelerometer
    wire w_4MHz;
    wire [14:0] acl_data;

    iclk_gen clock_generation(
        .CLK100MHZ(clk_100),
        .clk_4MHz(w_4MHz)
    );

    spi_master master(
        .iclk(w_4MHz),
        .miso(ACL_MISO),
        .sclk(ACL_SCLK),
        .mosi(ACL_MOSI),
        .cs(ACL_CSN),
        .acl_data(acl_data)
    );
   assign y   = acl_data[9]; 
   assign y_cord_internal = acl_data[8:5];
endmodule
