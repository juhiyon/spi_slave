`timescale 1ns / 1ps

module top
#(
	parameter	clk_freq = 125000000,
				spi_freq	= 1000000,
				data_width		= 8,	
				cpol			= 1,//�ʱ� clk 1
				cpha			= 1	//positive edge ��
)
(
	input clk,
	input rst_n,
	input [data_width-1:0]data_in,//miso�� ���� ������
	input sclk,
	input cs_n,//seclet line,cs_n=0�̸� ���õ� ��
	input mosi,//mosi�� �޴� ������
	output miso,
	output [data_width-1:0]data_out//mosi�� ���� ������ 
);

    localparam	shift_num = $clog2(data_width);   
    
    sclk_make_edge #(cpol,cpha) sclk_make_edge(clk,rst_n,cs_n,sclk,sampl_en,shift_en);//sampl_en
    cs_edge cs_edge(clk,rst_n,cs_n,cs_n_negedge);//cs_n_negedge
    s_miso #(data_width) s_miso(clk,rst_n,cs_n_negedge,data_in,cs_n,shift_en,miso);//miso
    s_mosi #(data_width,shift_num) s_mosi(clk,rst_n,mosi,sampl_en,cs_n,data_out);//data_out

endmodule
