module s_mosi//rx
#(
	parameter data_width=1,
	          shift_num=1
)
(
	input clk,
	input rst_n,
	input mosi,
	input sampl_en,
	input cs_n,
	output reg[data_width-1:0]data_out
);

reg	[shift_num:0]sampl_num;

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) //data_out 초기화
		data_out <= 'd0;
	else if (!cs_n & sampl_en) ///cs_n=0이고 sampl_en=1이ㅣ면 mosi값 shift
		data_out <= {data_out[data_width-2:0],mosi};
	else
		data_out <= data_out;
end

//the counter to count the number of sampled data bit
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) 
		sampl_num <= 'd0;
	else if (cs_n)
		sampl_num <= 'd0;
	else if (!cs_n & sampl_en) //shift 할 때마다 sampl_num +1
		if (sampl_num == data_width)//8번 하면 다시 1로 돌아가기
			sampl_num <= 'd0;
		else
			sampl_num <= sampl_num + 1'b1;
	else
		sampl_num <= sampl_num;
end

endmodule