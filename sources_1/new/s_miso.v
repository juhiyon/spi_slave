`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/04 15:39:21
// Design Name: 
// Module Name: s_miso
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

module s_miso//tx
#(
	parameter data_width=1
)
(
	input clk,
	input rst_n,
	input cs_n_negedge,
	input [data_width-1:0]data_in,
	input cs_n,
	input shift_en,
	output miso
);

reg [data_width-1:0] data_reg;

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) //리셋에서는 초기화
		data_reg <= 'd0;
	else if(cs_n_negedge)
		data_reg <= data_in;//cs_n되는 순간 보낼 데이터 싣기
	else if (!cs_n & shift_en) //cs_n=0이고 shift_en=1이면
		data_reg <= {data_reg[data_width-2:0],1'b0};//시프트 해주기
	else
		data_reg <= data_reg;
end

assign miso = !cs_n ? data_reg[data_width-1] : 1'd0;//cs_n=0이면 miso로 데이터 내보내기

endmodule