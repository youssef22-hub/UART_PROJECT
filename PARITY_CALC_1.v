module PARITY_CALC_1 (

input CLK,
input RST,
input [7:0] P_DATA,
input DATA_VALID,
input PAR_TYP,
input PAR_EN,
input BUSY,
output reg par_bit

);
reg [7:0] DATA ;

always @ (posedge CLK , negedge RST)
begin
	if (!RST)
	begin
		DATA <= 'b0;
	end

	 else if (DATA_VALID && !BUSY )
	begin
		DATA <= P_DATA;
	end
end

always @ (posedge CLK , negedge RST)	
begin
	if (!RST)
	begin
		par_bit <= 'b0;
	end
	else 
	begin
		if (PAR_EN)	
		begin
			case (PAR_TYP)
			1'b0 : begin
				par_bit <= ^DATA ;
				end
			1'b1 : begin
				par_bit <= !(^DATA) ;
				end
			endcase 
		end
	end
end
endmodule
