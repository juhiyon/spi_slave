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
	if (!rst_n) //data_out �ʱ�ȭ
		data_out <= 'd0;
	else if (!cs_n & sampl_en) ///cs_n=0�̰� sampl_en=1�̤Ӹ� mosi�� shift
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
	else if (!cs_n & sampl_en) //shift �� ������ sampl_num +1
		if (sampl_num == data_width)//8�� �ϸ� �ٽ� 1�� ���ư���
			sampl_num <= 'd0;
		else
			sampl_num <= sampl_num + 1'b1;
	else
		sampl_num <= sampl_num;
end

endmodule