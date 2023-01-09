`timescale 1ns / 1ps

module top
#(
	parameter	clk_freq = 125000000,
				spi_freq	= 1000000,
				data_width		= 8,	
				cpol			= 1,//초기 clk 1
				cpha			= 1	//positive edge 때
)
(
	input clk,
	input rst_n,
	input [data_width-1:0]data_in,//miso로 보낼 데이터
	input sclk,
	input cs_n,//seclet line,cs_n=0이면 선택된 것
	input mosi,//mosi로 받는 데이터
	output miso,
	output [data_width-1:0]data_out//mosi로 받은 데이터 
);

    localparam	shift_num = $clog2(data_width);   
    
    sclk_make_edge #(cpol,cpha) sclk_make_edge(clk,rst_n,cs_n,sclk,sampl_en,shift_en);//sampl_en
    cs_edge cs_edge(clk,rst_n,cs_n,cs_n_negedge);//cs_n_negedge
    s_miso #(data_width) s_miso(clk,rst_n,cs_n_negedge,data_in,cs_n,shift_en,miso);//miso
    s_mosi #(data_width,shift_num) s_mosi(clk,rst_n,mosi,sampl_en,cs_n,data_out);//data_out

endmodule
