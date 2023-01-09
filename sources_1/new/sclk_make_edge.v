`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/04 15:34:59
// Design Name: 
// Module Name: sclk_make
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


module sclk_make_edge
#(
	parameter	cpol=1,
	            cpha=1
)
(
	input clk,
	input rst_n,
	input cs_n,
	input sclk,
	output wire sampl_en,
	output wire shift_en
);

reg sclk_a;
reg sclk_b;
wire sclk_posedge;
wire sclk_negedge;

//clk���� cs_n=0�̸� ���õ� ��
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		sclk_a <= cpol;//�ʱ� sclk�� cpol�� �����
		sclk_b <= cpol;
	end 
	else if (!cs_n) begin
		sclk_a <= sclk;//sclk shift reg
		sclk_b <= sclk_a;
	end
end

assign sclk_posedge = ~sclk_b & sclk_a;//���� ���
assign sclk_negedge = ~sclk_a & sclk_b;

generate
	case (cpha)
		0: assign sampl_en = sclk_posedge;//rising���� sampl_en(rx) ���� ������ �ε�
		1: assign sampl_en = sclk_negedge;
		default: assign sampl_en = sclk_posedge;
	endcase
endgenerate

generate
 	case (cpha)
		0: assign shift_en = sclk_negedge;//falling���� shift_en(tx) , master �� �ݴ�
 		1: assign shift_en = sclk_posedge;
		default: assign shift_en = sclk_posedge;
	endcase
endgenerate

endmodule