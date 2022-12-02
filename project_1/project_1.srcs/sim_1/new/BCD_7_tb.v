`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2022 09:03:41 AM
// Design Name: 
// Module Name: BCD_7_tb
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


module BCD_7_tb();


reg clock;
always #1 clock = ~clock;

reg [5:0] timer_internal;
wire [7:0] cathode;
wire [7:0] anode;

BCD_7 uut(.clock(clock), .anode(anode));

initial begin
    clock = 1;
    timer_internal = 0;
end

endmodule
