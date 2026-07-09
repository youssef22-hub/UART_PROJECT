module REGISTER_FILE (
input [7:0] WrData,
input [3:0] Address,
input RdEn,
input WrEn,
input CLK,
input RST,
output reg [7:0]RdData,
output reg d_valid,
output wire [7:0] r0,
output wire [7:0] r1,
output wire [7:0] r2,
output wire [7:0] r3
);
reg [7:0] Reg_File [15:0];
integer i  ;

always @(posedge CLK , negedge RST)
begin 
	if (!RST)
		begin 
			RdData <= 'b0;
			d_valid <= 'b0;
			for (i = 0 ; i < 16 ; i = i + 1)
			begin
				if (i == 2)
				begin
					Reg_File[i] <= 'b100000_01;
				end
				else if (i == 3)
				begin
					Reg_File[i] <= 'b0010_0000;
				end
				else
				begin 
					Reg_File[i] <= 'b0;
				end
			end
		end
	else if (WrEn & !RdEn)
		Reg_File[Address] <= WrData ;
	else if (RdEn & !WrEn)
	begin
		RdData <= Reg_File[Address];
		d_valid <= 'b1;
	end
	else
   	begin
		d_valid <= 1'b0 ;
   	end
	
end 

assign r0 = Reg_File [0];
assign r1 = Reg_File [1];
assign r2 = Reg_File [2];
assign r3 = Reg_File [3];
endmodule

