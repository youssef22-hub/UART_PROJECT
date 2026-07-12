
########################### Define Top Module ############################
                                                   
set top_module SYS_TOP

######################### Formality Setup File ###########################

set synopsys_auto_setup true

set_svf "/home/IC/assignments/formal_sys_syn/syn/SYS_TOP.svf"


set SSLIB "/home/IC/tsmc_fb_cl013g_sc/aci/sc-m/synopsys/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/IC/tsmc_fb_cl013g_sc/aci/sc-m/synopsys/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/IC/tsmc_fb_cl013g_sc/aci/sc-m/synopsys/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

######################### Reference Container ############################

## Read Reference technology libraries

read_db -container r "/home/IC/tsmc_fb_cl013g_sc/aci/sc-m/synopsys/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"

## Read Reference Design Files
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/SYS_TOP.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/ALU_16B.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/Async_fifo.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/CLK_DIV.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/CLK_GATE.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/controller.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/DATA_SAMPLING_1.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/DATA_SYNC.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/DESERIALIZER_1.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/DF_Sync.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/EDGE_BIT_COUNTER_1.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/fifo_mem.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/fifo_rd.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/fifo_wr.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/FSM_1.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/FSM_rx_1.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/MUX_1.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/PARITY_CALC_1.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/PARITY_CHECK_1.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/PULSE_GEN.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/REGISTER_FILE.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/RST_SYNC.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/SERIALIZER_1.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/START_CHECK_1.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/STOP_CHECK_1.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/UART_RX_TOP.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/UART_TOP.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/UART_TX_1.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/SYS_TOP.v"
read_verilog -container r "/home/IC/assignments/formal_sys_syn/rtl/mux2X1.v"

## set the top Reference Design 

set_top SYS_TOP

######################## Implementation Container #########################

## Read Implementation technology libraries

read_db -container i "/home/IC/tsmc_fb_cl013g_sc/aci/sc-m/synopsys/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db" 

## Read Implementation Design Files
 
read_verilog -container i "/home/IC/assignments/formal_sys_syn/syn/SYS_TOP.v"

## set the top Implementation Design

set_top SYS_TOP

## matching Compare points
match

## verify
set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

report_passing_points > "passing_points.rpt"
report_failing_points > "failing_points.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"


start_gui
