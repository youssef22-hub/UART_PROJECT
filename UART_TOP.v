module UART (

//TX
input CLK_tb_top,
input RST_tb_top,
input  [7:0] P_DATA_tb_top,
input DATA_VALID_tb_top,
input PAR_EN_tb_top,
input  PAR_TYP_tb_top,
output TX_OUT_tb_top,
output BUSY_tb_top,


//RX


input rx_in_top,
input [5:0] prescale_top,
input par_en_top,
input par_typ_top,
input clk_top,
//input rst_top,
output data_valid_top,
output stop_error,
output par_error,
output [7:0] p_data_top



);






UART_TX_1 TX (

.CLK_tb(CLK_tb_top),
.RST_tb(RST_tb_top),
.P_DATA_tb(P_DATA_tb_top),
.DATA_VALID_tb(DATA_VALID_tb_top),
.PAR_EN_tb(PAR_EN_tb_top),
.PAR_TYP_tb(PAR_TYP_tb_top),
.TX_OUT_tb(TX_OUT_tb_top),
.BUSY_tb(BUSY_tb_top)


);



UART_RX RX (

.RX_IN(rx_in_top),//
.Prescale(prescale_top),//
.parity_enable(par_en_top),// 
.parity_type(par_typ_top),//
.CLK(clk_top),//
.RST(RST_tb_top),//
.data_valid(data_valid_top),//
.P_DATA(p_data_top),
.parity_error(par_error),
.framing_error(stop_error)


);

endmodule

