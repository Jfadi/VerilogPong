`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CECS 361
// Engineer: Omar Kanj Y Basha Zada
//////////////////////////////////////////////////////////////////////////////////


module clock_divider #(parameter div_value = 1)(
    input wire clk,
    output reg divided_clk = 0
    );
    
    integer counter_value = 0;
    
    always @(posedge clk) begin 
        if(counter_value == div_value)
            counter_value <= 0;
        else
            counter_value <= counter_value + 1;
    end
    
    always@(posedge clk) begin 
        if(counter_value == div_value) 
            divided_clk <= ~divided_clk;
    end
endmodule
