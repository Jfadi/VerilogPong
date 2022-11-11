`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CECS 361
// Engineers: 
//          - Omar Kanj Y Basha Zada 
//          - Fadi Jarray
//          - Minhanh Tran
//////////////////////////////////////////////////////////////////////////////////


module game(
    input quadA,
    input quadB,
    input clk_25,
    input [9:0] x,
    input [8:0] y,
    output [3:0] R,
    output [3:0] G,
    output [3:0] B,
    output reg [4:0] timer_out
    );

// clocking registers
integer clock_cycles = 0;
reg [7:0] sec_counter = 0;
reg [9:0] ms_counter = 0; // can go between 0 -> 1000
reg ms_clk = 0;

// game registers
reg [8:0] paddle_x_pos;
reg [2:0] quadAr, quadBr;
reg [4:0] ball_speed = 1;
reg [9:0] ball_x_pos = 5;
reg [9:0] ball_y_pos = 5;
reg negative_x = 0;
reg negative_y = 0;

// seconds counter
always@(posedge clk_25) begin
    // make sure the user started the game
    if (clock_cycles == 25000000) begin
        clock_cycles <= 0;
        ms_counter <= 0;
        sec_counter = sec_counter + 1;
    end else begin
        clock_cycles <= clock_cycles + 1;
    end
    if (clock_cycles%25000 == 0 && clock_cycles != 0) begin
        ms_clk = ~ms_clk; 
        ms_counter = ms_counter + 1;// Should count up to 1000 and then reset
    end 
end

assign timer_out <= sec_counter;


// paddle input
always @(posedge clk_25) quadAr <= {quadAr[1:0], quadA};
always @(posedge clk_25) quadBr <= {quadBr[1:0], quadB};

// paddle logic
always @(posedge ms_counter) begin
    if(quadA) begin
        if(~&paddle_x_pos)          // make sure the value doesn't overflow
        paddle_x_pos <= paddle_x_pos + 1;
    end else if(quadB) begin
       if(|paddle_x_pos)            // make sure the value doesn't underflow
       paddle_x_pos <= paddle_x_pos - 1;
    end
end

// ball logic
always@(posedge ms_clk) begin
    if(ms_counter%10 == 0) begin    // each 10 ms move the ball
        case ({negative_x,negative_y})
            2'b00: begin
                ball_x_pos = ball_x_pos + ball_speed;
                ball_y_pos = ball_y_pos + ball_speed;
            end
            2'b01: begin
                ball_x_pos = ball_x_pos + ball_speed;
                ball_y_pos = ball_y_pos - ball_speed;
            end
            2'b10: begin
                ball_x_pos = ball_x_pos - ball_speed;
                ball_y_pos = ball_y_pos + ball_speed;
            end
            2'b11: begin
                ball_x_pos = ball_x_pos - ball_speed;
                ball_y_pos = ball_y_pos - ball_speed;
            end
        endcase
    end else begin
        // x position tracking
        if(ball_x_pos <= 8) begin
            negative_x <= 0;
        end else if(ball_x_pos >= 610) begin
            negative_x <= 1;
        end

        if(ball_y_pos <= 0) begin
            negative_y <= 0;
        end else if(((ball_x_pos+30 > paddle_x_pos+8) && (ball_x_pos+30 < paddle_x_pos+120) && (ball_y_pos+30 > 432))) begin
            negative_y <= 1;
            // add a point              points = points + 1;
            // make the ball faster     ball_speed = ball_speed + 1;
        end else if (ball_y_pos >= 480) begin
            // lose flag
            // RESET GAME
        end
    end
end

wire border = (x[9:3]==0) || (x[9:3]==79) || (y[8:3]==0) || (y[8:3]==59);
wire paddle = (x>=paddle_x_pos+8) && (x<=paddle_x_pos+120) && (y[8:4]==27);
wire ball =   (x>ball_x_pos) && (x<ball_x_pos+30) && (y>ball_y_pos) && (y<ball_y_pos+30);

// needs to be muxed with multi states
// example: (this)
assign R[3] = border | paddle | ball;
assign G[3] = border | paddle | ball;
assign B[3] = border | paddle | ball;

endmodule
