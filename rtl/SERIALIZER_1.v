module SERIALIZER_1 (
  input CLK,
  input RST,
  input BUSY,
   input DATA_VALID,
  input [7:0] P_DATA,
  input ser_en,
  output  ser_data,
  output  ser_done
);

  reg [7:0] shift_reg;
  reg [2:0] bit_count;

/*always @(posedge CLK or negedge RST) 
begin
    if (!RST) 
	begin
		shift_reg <= 8'b0;
		ser_data <= 0;
		
        end
    else if (DATA_VALID && !BUSY )
	begin
	   shift_reg <= P_DATA;
           ser_data <= P_DATA[0];       
     
	 end
    else if (ser_en) 
		begin
			//ser_data <= shift_reg[0];
          		shift_reg <= shift_reg >> 1;
        		ser_data <= shift_reg[0];       
        		

      		end 
 	else 
		begin
			ser_data <= 'b0;
     			
       			   
      		end
    
end

assign ser_done = (bit_count == 7);

always @(posedge CLK , negedge RST)
begin 
	if (!RST)
		bit_count <= 'b111 ;
	else if (  ser_en )
		bit_count <= bit_count + 'b1 ;
	else 
		bit_count <= 'b0;
end

endmodule  */

always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    shift_reg <= 'b0 ;
   end
  else if(DATA_VALID && !BUSY)
   begin
    shift_reg <= P_DATA ;
   end	
  else if(ser_en)
   begin
    shift_reg <= shift_reg >> 1 ;         
   end
 end
 

//counter
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    bit_count <= 'b0 ;
   end
  else
   begin
    if (ser_en)
	 begin
      bit_count <= bit_count + 'b1 ;		 
	 end
	else 
	 begin
      bit_count <= 'b0 ;		 
	 end	
   end
 end 

assign ser_done = (bit_count == 'b111) ? 1'b1 : 1'b0 ;

assign ser_data = shift_reg[0] ;

endmodule

