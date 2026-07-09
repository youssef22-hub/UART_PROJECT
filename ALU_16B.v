module ALU_16B(
input wire [7:0] A,
input wire [7:0] B,
input wire [3:0] ALU_FUN,
input wire  CLK,
input enable,
input rst,
output reg [7:0] ALU_OUT,
output reg        OUT_VALID );


always @ ( posedge CLK , negedge rst)
begin



	if (!rst)
	begin
		ALU_OUT <= 'b0 ;
		OUT_VALID <= 'b0 ;
	end
	else if (enable)
	begin
		OUT_VALID <= 'b1 ;
		case (ALU_FUN)
			4'b0000: begin
					 ALU_OUT  <= A + B ;
				 end

			4'b0001: begin
					 ALU_OUT  <= A - B ;
				 end
	
			4'b0010: begin
					ALU_OUT <= A * B ;
				 end
 
			4'b0011: begin
					ALU_OUT <= A / B ;
				 end

			4'b0100: begin
					ALU_OUT <= A & B ;
				 end

			4'b0101: begin
					ALU_OUT <= ( A | B ) ;
			 	end

			4'b0110: begin
					ALU_OUT <= ~( A & B );
				 end

			4'b0111: begin
					ALU_OUT <= ~( A | B ) ;
				 end

			4'b1000: begin
					ALU_OUT <= ( A ^ B );
				 end

			4'b1001: begin
					ALU_OUT <= ~( A ^ B ) ;
				 end

			4'b1010: begin
					if ( A == B )
						begin 
							ALU_OUT <= 'b1;
						end
					else 
						begin
							ALU_OUT <= 'b0;
						end
				 end

			4'b1011: begin
					if ( A > B )
						begin 
							ALU_OUT <= 'b10;
						end
					else 
						begin
							ALU_OUT <= 'b0;
						end
				 end

			4'b1100: begin
					if ( A < B )
						begin 
							ALU_OUT <= 'b11;
						end
					else 
						begin
							ALU_OUT <= 'b0;
						end
				 end

			4'b1101: begin
					ALU_OUT <= A >> 1 ;
				 end

			4'b1110: begin
					ALU_OUT <= A << 1 ;
				 end
	
			default: begin
					ALU_OUT <= 'b0 ;
				 end
		endcase
	end
	else 
		OUT_VALID <= 'b0 ;
end



endmodule

