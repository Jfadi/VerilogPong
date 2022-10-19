`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//////////////////////////////////////////////////////////////////////////////////


module display(
    input clk_25,
    input       [3:0] R_in,
    input       [3:0] G_in,
    input       [3:0] B_in,
    output reg  [3:0] R_out,
    output reg  [3:0] G_out,
    output reg  [3:0] B_out,
    output reg hsync = 1,
    output reg vsync = 1,
    output integer Hcount,
    output integer Vcount
    );

integer hcounter = 0;
integer vcounter = 0;

always @(posedge clk_25) begin

    if (hcounter == 0 && vcounter < 480) begin
        R_out <= R_in;
        G_out <= G_in;
        B_out <= B_in;
    end
    else if (hcounter == 640) begin
        R_out <= 0;
        G_out <= 0;
        B_out <= 0;
    end
    if (vcounter == 480) begin
        R_out <= 0;
        G_out <= 0;
        B_out <= 0;
    end
        // vcounter <= 0;
    // end
    Hcount <= hcounter;
    Vcount <= vcounter;
end

always@(posedge clk_25) begin
    if (hcounter == 0)
        hsync <= 1; // start horizantal syncing
    else if(hcounter == 655)
        hsync <= 0;
    else if(hcounter == 751)
        hsync <= 1;
    else if(hcounter == 799) begin
        vcounter <= vcounter + 1;
        hcounter <= 0;
    end

    if (vcounter == 0)
        vsync <= 1; // start vertical syncing
    else if(vcounter == 489)
        vsync <= 0;
    else if(vcounter == 491)
        vsync <= 1;
    else if(vcounter == 524)
        vcounter <= 0;

    hcounter = hcounter + 1;
end
// always@(posedge clk_25) begin
    //  vsync ? 0 : 0;
// end




endmodule
