
module FSM_1 (

input DATA_VALID ,
input ser_done,
input CLK,
input RST,
input PAR_EN,
output reg ser_en,
output reg BUSY,
output reg [1:0] mux_sel


);

localparam [2:0] idle = 'b000;
localparam [2:0] start = 'b001;
localparam [2:0] data = 'b011;
localparam [2:0] parity = 'b010;
localparam [2:0] stop = 'b110;

reg [2:0] current_state ;
reg [2:0] next_state ;

reg BUSY_C ;


always @ (posedge CLK , negedge RST)

begin
	if (!RST)
		current_state <= idle;
	else 
		current_state <= next_state;

end 




always @ (*)

begin
	case(current_state)
	
		idle : 	begin
				if (DATA_VALID)
					next_state <= start;
				else 
					next_state <= idle;
			end

		start : begin
				next_state <= data;
			end 

		data : begin
				if (ser_done & PAR_EN)
				next_state <= parity;
				else if (ser_done & !PAR_EN)
				next_state <= stop;
				else 
				next_state <= data;
			end

		parity : begin
				next_state <= stop;
			 end	
		
		stop : begin 
				
				next_state <= idle;
			end
		default : begin
				next_state <= idle;
			  end
		
	endcase
end 


always @ (*)
begin
	case (current_state)
	
		idle : begin
				ser_en = 'b0; 
				BUSY_C = 'b0;	
				mux_sel = 'b01;
				
			end
		
		start : begin
				ser_en = 'b0; 
				BUSY_C = 'b1;	
				mux_sel = 'b00;
				
			end

		data : begin	
				if (ser_done)
				ser_en = 'b0;
				else
				ser_en = 'b1; 
				BUSY_C = 'b1;
				mux_sel = 'b10;
	
			end
		
		parity : begin
				ser_en = 'b0; 
				BUSY_C = 'b1;
				mux_sel = 'b11;
				
			end

		stop : begin
				ser_en = 'b0; 
				BUSY_C = 'b1;
				mux_sel = 'b01;
				
			end
		default : begin
				ser_en = 'b0; 
				BUSY_C = 'b0;
				mux_sel = 'b1;
				
			end
		
	endcase
end
	
/*always @(posedge CLK , negedge RST)
begin
if(!RST)
	BUSY <= 'b0;
else if (current_state == idle )
	 BUSY <= 'b0;
else if (current_state == start || current_state == data || current_state == parity || current_state == stop )
	 BUSY <= 'b1;
else 
	BUSY <= 'b0; 
end 
*/ 

always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    BUSY <= 1'b0 ;
   end
  else
   begin
    BUSY <= BUSY_C ;
   end
 end

endmodule























