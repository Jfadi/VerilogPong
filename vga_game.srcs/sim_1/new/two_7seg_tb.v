`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2022 05:54:12 PM
// Design Name: 
// Module Name: two_7seg_tb
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


module two_7seg_tb();

reg clk;
always #1 clk = ~clk;

reg [5:0] timer_internal;
wire [7:0] cathode;
wire [7:0] anode;

two_7seg uut(.clk_25(clk), .in(timer_internal), .cathode(cathode), .anode(anode));

initial begin
    clk = 1;
    timer_internal = 0;
end

endmodule
