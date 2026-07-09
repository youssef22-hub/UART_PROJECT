module UART_TX_1 (

input CLK_tb,
input RST_tb,
input  [7:0] P_DATA_tb,
input DATA_VALID_tb,
input PAR_EN_tb,
input  PAR_TYP_tb,
output TX_OUT_tb,
output BUSY_tb );

wire ser_en_tb;
wire ser_done_tb;
wire [1:0] mux_sel_tb;
wire par_bit_tb;
wire ser_data_tb;





FSM_1 FSM_1_tb 
(

.DATA_VALID(DATA_VALID_tb),
.ser_done(ser_done_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.ser_en(ser_en_tb),
.PAR_EN(PAR_EN_tb),
.BUSY(BUSY_tb),
.mux_sel(mux_sel_tb)

);

SERIALIZER_1 SERIALIZER_1_tb 
(

.DATA_VALID(DATA_VALID_tb),
.BUSY(BUSY_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.P_DATA(P_DATA_tb),
.ser_en(ser_en_tb),
.ser_done(ser_done_tb),
.ser_data(ser_data_tb)




);

PARITY_CALC_1 PARITY_CALC_1_tb 
(

.CLK(CLK_tb),
.RST(RST_tb),
.P_DATA(P_DATA_tb),
.DATA_VALID(DATA_VALID_tb),
.PAR_TYP(PAR_TYP_tb),
.PAR_EN(PAR_EN_tb),
.BUSY(BUSY_tb),
.par_bit(par_bit_tb)




);

MUX_1 MUX_1_tb 
(

.CLK(CLK_tb),
.RST(RST_tb),
.mux_sel(mux_sel_tb),
.ser_data(ser_data_tb),
.TX_OUT(TX_OUT_tb),
.par_bit(par_bit_tb)



);

endmodule 

