module RST_SYNC #(parameter number_stage = 2)(

input clk,
input rst,
output sync_rst

);

reg [number_stage - 1 : 0] stages  ;
always @(posedge clk , negedge rst)
begin
	if (!rst)
	begin
	stages <= 'b0;
	end
	else 
	stages <= {stages[ number_stage - 2 : 0 ],1'b1};
end

assign sync_rst = stages [number_stage - 1];

endmodule 