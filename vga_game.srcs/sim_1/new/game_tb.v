`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2022 02:38:56 PM
// Design Name: 
// Module Name: game_tb
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


module game_tb();


wire [3:0] R_internal; 
wire [3:0] G_internal;
wire [3:0] B_internal;
//wire [9:0]  ms;
reg [9:0] h_pos_internal;
reg [9:0] v_pos_internal;

reg clk_25_internal = 1;

always #10 clk_25_internal = ~clk_25_internal;

game    uut(.clk_25(clk_25_internal), .R(R_internal), .G(G_internal), .B(B_internal), .x(h_pos_internal), .y(v_pos_internal));//, .ms_counter_out(ms));

integer i;
integer j;

initial begin

    for(i = 0; i < 650; i = i+1) begin
        for(j = 0; j< 490; j = j+1) begin
            h_pos_internal = i;
            v_pos_internal = j;
            #10;
        end
    end


end
endmodule
