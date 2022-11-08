`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CECS 361
// Engineers: 
//          - Omar Kanj Y Basha Zada 
//          - Fadi Jarray
//          - Minhanh Tran
//////////////////////////////////////////////////////////////////////////////////


module game(
    input clk_25,
    input [9:0] x,
    input [9:0] y,
    output reg [3:0] R,
    output reg [3:0] G,
    output reg [3:0] B,
    output reg [4:0] timer_out,
    output [9:0] ms_counter_out
    );

integer clock_cycles = 0;
reg [7:0] sec_counter = 0;
reg [9:0] ms_counter = 0; // can go between 0 -> 1000

assign ms_counter_out = ms_counter;
// adding seconds to the counter
always@(posedge clk_25) begin
    // make sure the user started the game
    if (clock_cycles%25000 == 0) begin
        ms_counter = ms_counter + 1;    // Should count up to 1000 and then reset
    end
    if (clock_cycles == 25000000) begin
        clock_cycles <= 0;
        ms_counter <= 0;
        sec_counter = sec_counter + 1;
    end
    else begin
        clock_cycles <= clock_cycles + 1;
    end
end

always@(sec_counter) begin
    timer_out <= sec_counter;
end


//  use the ms as the driver for the physics we are implementing for the balls
//  example

// game logic

reg [9:0] ball_x_pos = 80;
reg [9:0] ball_y_pos = 80;
reg [9:0] platform_x_pos;
reg negative_x = 0;
reg negative_y = 0;

reg [5:0] speed = 0;

// physics
always@(ms_counter) begin

    if(ms_counter%50 == 0) begin
        if(ball_x_pos == 0) begin
            negative_x <= 0;
        end else if(ball_x_pos == 640) begin
            negative_x <= 1;
        end
        if(ball_y_pos == 0) begin
            negative_y <= 0;
        end else if(ball_y_pos == 480) begin
            negative_y <= 1;
        end

        case ({negative_x,negative_y})
            2'b00: begin
                ball_x_pos = ball_x_pos + speed;
                ball_y_pos = ball_y_pos + speed;
            end
            2'b01: begin
                ball_x_pos = ball_x_pos + speed;
                ball_y_pos = ball_y_pos - speed;
            end
            2'b10: begin
                ball_x_pos = ball_x_pos - speed;
                ball_y_pos = ball_y_pos + speed;
            end
            2'b11: begin
                ball_x_pos = ball_x_pos - speed;
                ball_y_pos = ball_y_pos - speed;
            end
        endcase
    end
end

// render
always@(posedge clk_25) begin
    if( x < (ball_x_pos + 5) && x > (ball_x_pos - 5)) begin
        R <= 4'b1111;
        G <= 4'b1111;
        B <= 4'b1111;
    end else begin
        R <= 4'b0000;
        G <= 4'b0000;
        B <= 4'b0000;
    end

end
//
//

endmodule
