`timescale 1ns/1ps
module sys_tb;

  reg  ref_clk_tb = 0;
  reg  uart_clk_tb = 0;
  reg  rst_sys_tb = 1;
  reg  rx_in_tb   = 1;   
  wire tx_out_tb;
  wire parritty_err_tb;
  wire stp_err_tb;

  reg  tx_clk = 0;
  reg  rx_clk = 0;

  localparam integer T_REF  = 100;    
  localparam integer T_UART = 271;    
  localparam integer T_TX   = 8681;   
  localparam integer T_RX   = T_UART;

  integer i ;
	integer k ;
reg [10:0] tx_out_1 = 'b11000010100;
reg [10:0] number ;

  always #(T_REF/2)  ref_clk_tb  = ~ref_clk_tb;
  always #(T_UART/2) uart_clk_tb = ~uart_clk_tb;
  always #(T_TX/2)   tx_clk      = ~tx_clk;
  always #(T_RX/2)   rx_clk      = ~rx_clk;

  SYS_TOP dut (
    .ref_clk (ref_clk_tb),
    .uart_clk(uart_clk_tb),
    .rst_sys (rst_sys_tb),
    .rx_in   (rx_in_tb),
    .tx_out  (tx_out_tb),
    .parritty_err(parritty_err_tb),
    .stp_err(stp_err_tb)
  );

  task reset; begin
    @(negedge uart_clk_tb); rst_sys_tb = 0;
    @(negedge uart_clk_tb); rst_sys_tb = 1;
  end endtask

  initial begin 
    reset();
	send_frame(8'b10101010, 1'b0); // send AA to write 
	gap_ref(3);
	send_frame(8'b00001000, 1'b1); //send address 8 to write in
	gap_ref(3);
	send_frame(8'b11111111, 1'b0); // send data will written
	gap_ref(4);
	send_frame(8'b10111011, 1'b0); // send BB to read
	gap_ref(3);
	send_frame(8'b00001000, 1'b1); // send address 8 to read
	gap_ref(4);
	@(negedge tx_clk);
	@(negedge tx_clk);
	@(negedge tx_clk);
	@(negedge tx_clk);
	check('b10111111110); // test for read
	send_frame(8'b11001100, 1'b0); // send CC to alu 
	gap_ref(3);
	send_frame(8'b00000111, 1'b1); // send value of a written in address 0
	gap_ref(3);
	send_frame(8'b00000011, 1'b0); // send value of a written in address 1
	gap_ref(3);
	send_frame(8'b00000000, 1'b0); // send alu func 0 to add
	gap_ref(4);
	gap_ref(1);
	@(negedge tx_clk);
	@(negedge tx_clk);
	@(negedge tx_clk);
	@(negedge tx_clk);
	check('b10000010100); // test for alu op 
	send_frame(8'b11011101, 1'b0); //send DD to alu with no op
	gap_ref(3);
	send_frame(8'b00000001, 1'b1); // send alu func 1 to sub
	gap_ref(4);
	gap_ref(1);
	@(negedge tx_clk);
	@(negedge tx_clk);
	@(negedge tx_clk);
	@(negedge tx_clk);
	check('b11000001000); // test for alu op with no operand
	
	

 	    $stop;
  end

	
task send_frame; //send from rx
  input [7:0] data;     
  input       parity;   
  integer i;
	integer j;
  begin
    // start bit
    rx_in_tb = 1'b0;
    for (i=0; i<32; i=i+1) @(negedge rx_clk);

    // data bits
    for (i=0; i<8; i=i+1) begin
      rx_in_tb = data[i];
      for ( j=0; j<32; j=j+1) @(negedge rx_clk);
    end

    // parity bit
    rx_in_tb = parity;
    for (i=0; i<32; i=i+1) @(negedge rx_clk);

    // stop bit
    rx_in_tb = 1'b1;
    for (i=0; i<32; i=i+1) @(negedge rx_clk);
	@(negedge rx_clk);
  end
endtask


task gap_ref;  // to data sync
  input integer n;
  integer g;
  begin
    for (g = 0; g < n; g = g + 1)
      @(negedge ref_clk_tb);
  end
endtask

task check;
integer k;
input [10:0] data_check;
reg [10:0] number;
begin
for (k = 0; k < 11; k = k + 1)
	begin
		
		if (tx_out_tb == data_check[k] )
			begin
				number[k] = 'b1;
			end
		else 
			begin
				number[k] = 'b0;
			end
		@(negedge tx_clk);
	end

	if (number == 'b11111111111)
		$display ("test pass ");
	else 
		$display ("test fail ",number);


end
endtask
endmodule
