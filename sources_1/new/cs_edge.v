module cs_edge
(
	input clk,
	input rst_n,
	input cs_n,
	output wire cs_n_negedge
);

reg cs_n_a;
reg cs_n_b;

//cs_n에 대한 엣지 잡기
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		cs_n_a	<= 1'b1;
		cs_n_b	<= 1'b1;
	end else begin
		cs_n_a	<= cs_n	;
		cs_n_b	<= cs_n_a;
	end
end

assign cs_n_negedge = ~cs_n_a & cs_n_b;

endmodule