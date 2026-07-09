module controller #(parameter width = 8 , parameter width_alu = 16)(

input clk,
input rst,
input [width-1 : 0] data,
input data_valid,
input [7:0] rd_d,
input rd_d_valid,
input [7:0] alu_out,
input alu_valid,
input fifo_full,
output reg wr_inc,
output reg [7:0] wr_data,
output reg wren,
output reg rden,
output reg [3:0] addr,
output reg [7:0] wr_d,
output reg [3:0] fun_alu,
output reg en_alu,
output reg gate_en


);

localparam [3:0] idle = 'b0000;
localparam [3:0] first_register_write = 'b0001;
localparam [3:0] sec_register_write = 'b0011;
localparam [3:0] first_register_read = 'b0111;
localparam [3:0] read_out = 'b1111;
localparam [3:0] first_alu_op = 'b1011;
localparam [3:0] sec_alu_op = 'b1001;
localparam [3:0] third_alu_op = 'b1000;
localparam [3:0] first_alu_no_op = 'b1100;
localparam [3:0] alu_state_out = 'b1110;


reg [3:0] current_state ;
reg [3:0] next_state ;

reg data_valid_cntrl ;

always @(posedge clk , negedge rst)
begin

	if (!rst)
	data_valid_cntrl <= 'b0;
	else 
	data_valid_cntrl <= data_valid;

end


always @(posedge clk , negedge rst)
begin

	if (!rst)
	current_state <= idle;
	else 
	current_state <= next_state;

end


always @ (*)
begin

	case (current_state)
	
	idle :   begin
				if (data == 'b10101010  & data_valid_cntrl )
				next_state = first_register_write;
				else if (data == 'b10111011 & data_valid_cntrl)
				next_state = first_register_read;
				else if (data == 'b11001100 & data_valid_cntrl)
				next_state = first_alu_op;
				else if (data == 'b11011101 & data_valid_cntrl)
				next_state = first_alu_no_op;
				else 
				next_state = idle;
			 end
			 
	first_register_write : begin
							if (data_valid_cntrl)
							next_state = sec_register_write;
							else 
							next_state = first_register_write;
						   end
						   
	sec_register_write : begin
							if (data_valid_cntrl)
							next_state = idle;
							else 
							next_state = sec_register_write;
						 end
						 
	first_register_read : begin 
							if (data_valid)
							next_state = read_out;
							else 
							next_state = first_register_read;
						  end 
						  
	read_out : begin
				if (rd_d_valid)
				next_state = idle;
				else
				next_state = read_out;
			   end
						  
	first_alu_op : begin
					if (data_valid_cntrl)
					next_state = sec_alu_op;
					else
					next_state = first_alu_op;
				   end 

	sec_alu_op : begin 
					if (data_valid_cntrl)
					next_state = third_alu_op;
					else 
					next_state = sec_alu_op;
					end
					
	third_alu_op : begin
					if (data_valid_cntrl)
					next_state = alu_state_out;
					else 
					next_state = third_alu_op;
					end
					
	first_alu_no_op : begin
					  if (data_valid_cntrl)
					  next_state = alu_state_out;
					  else 
					  next_state = first_alu_no_op;
					  end
					  
	alu_state_out : begin
				if (alu_valid)
				next_state = idle;
				else
				next_state = alu_out;
			  end
			  
	default : next_state = idle;		  
	endcase
end


always @ (*)
begin
	case (current_state)
		
		
				
	idle :   begin
	
				wr_inc ='b0;
				wr_data = 'b0;
				wren = 'b0;
				rden = 'b0;
				addr = 'b0;
				wr_d = 'b0;
				fun_alu = 'b1111;
				en_alu = 'b0;
				gate_en = 'b0;
				
			 end
			 
	first_register_write : begin
	
						    wr_inc = 'b0;
							wr_data = 'b0;
							wren = 'b0;
							rden = 'b0;
							
							addr = data[3:0];

							wr_d = 'b0;
							fun_alu = 'b0;
							en_alu = 'b0;
							gate_en = 'b0;
	
						   end
						   
	sec_register_write : begin
	
						wr_inc = 'b0;
						wr_data = 'b0;
						wren = 'b1;
						rden = 'b0;
						addr = addr;
						
							wr_d = data;
						
						fun_alu = 'b0;
						en_alu = 'b0;
						gate_en = 'b0;

						 end
						 
	first_register_read : begin 

						    wr_inc = 'b0;
							wr_data = 'b0;
							wren = 'b0;
							rden = 'b0;
							
							addr = data[3:0];
							
							wr_d = 'b0;
							fun_alu = 'b0;
							en_alu = 'b0;
							gate_en = 'b0;
						  
						  end 
						  
	read_out : begin
	
						        if (!fifo_full & rd_d_valid)
							begin
								wr_inc = 'b1;
								wr_data = rd_d;
							end
							else
							begin
								wr_inc = 'b0;
								wr_data = 'b0;
							end
							wren = 'b0;
							rden = 'b1;
							addr = data;
							wr_d = 'b0;
							fun_alu = 'b0;
							en_alu = 'b0;
							gate_en = 'b0;
							
			   end
						  
	first_alu_op : begin
 
				    wr_inc = 'b0;
					wr_data ='b0;
					wren = 'b1;
					rden = 'b0;
					
						addr = 'b0;
					
						
					
					
						wr_d = data;
					
						
					fun_alu ='b0;
					en_alu = 'b0;
					gate_en ='b0;
				   
				   end 

	sec_alu_op : begin 
	
					wr_inc = 'b0;
					wr_data = 'b0;
					wren = 'b1;
					rden = 'b0;
					
						addr = 'b1;
					
						
					
					
						wr_d = data;
					
					fun_alu ='b0;
					en_alu = 'b0;
					gate_en ='b0;
					
					end
					
	third_alu_op : begin
	
				        wr_inc = 'b0;
					wr_data ='b0;
					wren = 'b0;
					rden = 'b0;
					addr = 'b0;
					wr_d = 'b0;
					if (data_valid_cntrl)
						fun_alu = data[3:0];
					else 
						fun_alu = 'b1111;
					
					if (data_valid_cntrl)
						en_alu ='b1 ;
					else 
						 en_alu = 'b0 ;
					
					gate_en ='b1;
	
					end
					
	first_alu_no_op : begin

				 	wr_inc = 'b0;
					wr_data ='b0;
					wren = 'b0;
					rden = 'b0;
					addr = 'b0;
					wr_d = 'b0;
					if (data_valid_cntrl)
						fun_alu = data[3:0];
					else 
						fun_alu = 'b1111;
					
					if (data_valid_cntrl)
						en_alu ='b1 ;
					else 
						 en_alu = 'b0 ;
					
					gate_en ='b1;

					  end
					  
	alu_state_out : begin
				 
					if (!fifo_full)
					begin
						wr_inc = 'b1;
						wr_data = alu_out; 
					end
					else
					begin
						wr_inc = 'b0;
						wr_data = 'b0;
					end
					wren ='b0;
					rden ='b0;
					addr ='b0;
					wr_d ='b0;
					fun_alu = 'b1111;
					en_alu = 'b0;
					gate_en ='b1;
					
			  end
		
	default : 	begin
	
				wr_inc ='b0;
				wr_data = 'b0;
				wren = 'b0;
				rden = 'b0;
				addr = 'b0;
				wr_d = 'b0;
				fun_alu = 'b1111;
				en_alu = 'b0;
				gate_en = 'b0;
				
			 end
	endcase		  
end


endmodule

