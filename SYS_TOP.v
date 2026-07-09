module SYS_TOP (

input ref_clk,
input uart_clk,
input rst_sys,
input rx_in,
output tx_out,
output parritty_err,
output stp_err

);


wire [7:0] out_rx ;
wire valid_rx ;
wire [7:0] out_data_sync ;
wire valid_data_sync ;
wire wr_register_en ;
wire rd_register_en ;
wire [3:0] address_register ;
wire [7:0] wr_register_data ;
wire [7:0] rd_register_data ;
wire rd_register_valid ;
wire [7:0] op_a; // REG0
wire [7:0] op_b;  //REG1
wire [3:0] func_alu ;
wire en_alu_sys ;
wire [7:0] alu_out_sys ;
wire alu_valid_sys ;
wire gate_en_sys ;
wire [7:0] in_fifo ;
wire wr_inc_fifo ;
wire fifo_full_sys ;
wire rst_1 ;
wire rst_2 ;
wire rx_clk ;
wire tx_clk;
wire [7:0] out_fifo ; 
wire fifo_empty ;
wire rd_inc_fifo ;
wire busy ;
wire alu_clk ;
wire [7:0] register_2;
wire [7:0] register_3;
wire [7:0] reg_1 = 'b1;



UART uart_dut (

.CLK_tb_top(tx_clk),
.RST_tb_top(rst_1),
.P_DATA_tb_top(out_fifo),
.DATA_VALID_tb_top(!fifo_empty),
.PAR_EN_tb_top(register_2[0]),
.PAR_TYP_tb_top(register_2[1]),
.TX_OUT_tb_top(tx_out),
.BUSY_tb_top(busy),
.rx_in_top(rx_in),
.prescale_top(register_2[7:2]),
.par_en_top(register_2[0]),
.par_typ_top(register_2[1]),
.clk_top(rx_clk),
.data_valid_top(valid_rx),
.p_data_top(out_rx),
.par_error(parritty_err),
.stop_error(stp_err)

); 



DATA_SYNC DATA_SYNC_dut (

.clk(ref_clk),
.rst(rst_2),
.bus_enable(valid_rx),
.unsync_bus(out_rx),
.enable_pulse(valid_data_sync),
.sync_bus (out_data_sync)


);


controller controller_dut (

.clk(ref_clk),
.rst(rst_2),
.data(out_data_sync),
.data_valid(valid_data_sync),
.rd_d(rd_register_data),
.rd_d_valid(rd_register_valid),
.alu_out(alu_out_sys),
.alu_valid(alu_valid_sys),
.fifo_full(fifo_full_sys),
.wr_inc(wr_inc_fifo),
.wr_data(in_fifo),
.wren(wr_register_en),
.rden(rd_register_en),
.addr(address_register),
.wr_d(wr_register_data),
.fun_alu(func_alu ),
.en_alu(en_alu_sys),
.gate_en(gate_en_sys)

);


ALU_16B ALU_dut (

.A(op_a),
.B(op_b),
.ALU_FUN(func_alu),
.CLK(alu_clk),
.rst(rst_2),
.ALU_OUT(alu_out_sys),
.enable(en_alu_sys),
.OUT_VALID(alu_valid_sys)


);


REGISTER_FILE regfile_dut (

.WrData(wr_register_data),
.Address(address_register),
.RdEn(rd_register_en),
.WrEn(wr_register_en),
.CLK(ref_clk),
.RST(rst_2),
.RdData(rd_register_data),
.d_valid(rd_register_valid),
.r0(op_a),
.r1(op_b),
.r2(register_2),
.r3(register_3)

);



RST_SYNC rst_1_dut (

.clk(uart_clk),
.rst(rst_sys),
.sync_rst(rst_1)


);


RST_SYNC rst_2_dut (

.clk(ref_clk),
.rst(rst_sys),
.sync_rst(rst_2)


);


CLK_GATE clk_gate_dut (

.CLK_EN(gate_en_sys),
.CLK(ref_clk),
.GATED_CLK(alu_clk)

);


CLK_DIV clk_div_tx_dut (

.i_ref_clk(uart_clk),
.i_rst(rst_1),
.i_clk_en(register_2[0]),
.i_div_ratio(register_3),
.o_div_clk(tx_clk)


);


CLK_DIV clk_div_rx_dut (

.i_ref_clk(uart_clk),
.i_rst(rst_1),
.i_clk_en(register_2[0]), 
.i_div_ratio(reg_1),
.o_div_clk(rx_clk)


);


PULSE_GEN pulse_gen_dut (

.clk(tx_clk),
.rst(rst_1),
.lvl_sig(busy),
.pulse_sig(rd_inc_fifo)


);


Async_fifo async_fifo_fifo (

.i_w_clk(ref_clk),           
.i_w_rstn(rst_2),       
.i_w_inc(wr_inc_fifo),         
.i_r_clk(tx_clk),        
.i_r_rstn(rst_1),       
.i_r_inc(rd_inc_fifo),          
.i_w_data(in_fifo),            
.o_r_data(out_fifo),             
.o_full(fifo_full_sys),              
.o_empty(fifo_empty)          


);

endmodule
