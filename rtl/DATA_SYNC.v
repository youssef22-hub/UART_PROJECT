module DATA_SYNC #(parameter number_stage = 2  ) (

input clk,
input rst,
input bus_enable,
input [7:0] unsync_bus,
output enable_pulse,
output reg [7:0] sync_bus 

);

reg [number_stage - 1 : 0] chain ;
wire sync_enable;
reg pulse_flop;


always @ (posedge clk , negedge rst)
begin
	if (!rst)
	begin
		chain <= 'b0;
	end
	
	else 
	chain <= {chain [number_stage - 2 : 0] , bus_enable};
	
end

assign sync_enable = chain [number_stage - 1] ;

always @ (posedge clk , negedge rst)
begin
	if (!rst)
	begin 
		pulse_flop <= 'b0;
	end
	
	else 
	pulse_flop <= sync_enable ; 
	

end

assign enable_pulse = sync_enable & !pulse_flop ;


always @ (posedge clk , negedge rst)
begin
	if (!rst) 
	begin
		sync_bus <= 'b0;
	end

	else if (enable_pulse)
		sync_bus <= unsync_bus;
	else 
		sync_bus <= sync_bus;
		
end


endmodule 