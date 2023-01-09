`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/03 19:05:56
// Design Name: 
// Module Name: tb
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
module tb;
    reg clk;
    reg rst_n;
    
    reg [8-1:0] data_in;//tx miso로 보낼 데이터
    reg sclk;
    reg cs_n;
    reg mosi;//rx mosi로 받는 데이터
    wire miso;
    
    //rx(miso)
    wire [8-1:0] data_out;//miso로 받은 데이터
    
    top top(.clk(clk),.rst_n(rst_n),.data_in(data_in),.miso(miso),.mosi(mosi),.data_out(data_out),.sclk(sclk),.cs_n(cs_n));
    parameter step =50;
    
always #(step/2) clk=~clk;
always #(250*step/2) sclk=~sclk;

initial begin
    sclk=1; clk=1; rst_n=0; cs_n=1; #step;//초기화
    rst_n=1; #step;
    cs_n=0; data_in=8'b00010011; mosi=1; 
end

endmodule
