module MUX_1 (

input [1:0] mux_sel,
input ser_data,
input CLK,
input RST,
input par_bit,
output reg TX_OUT


);

localparam start_bit = 'b0;
localparam stop_bit = 'b1;

always @ (posedge CLK , negedge RST)
begin
	if (!RST)
	begin
		TX_OUT <= 'b1;
	end

	else 
	begin
		case (mux_sel)
			'b00 : TX_OUT <= start_bit ;
			'b01 : TX_OUT <= stop_bit ;
			'b10 : TX_OUT <= ser_data ;
			'b11 : TX_OUT <= par_bit;
		endcase 
	end 




end

endmodule

