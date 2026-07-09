onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sys_tb/dut/clk_div_tx_dut/o_div_clk
add wave -noupdate /sys_tb/ref_clk_tb
add wave -noupdate /sys_tb/uart_clk_tb
add wave -noupdate /sys_tb/dut/clk_div_rx_dut/o_div_clk
add wave -noupdate -expand -group UART /sys_tb/dut/uart_dut/P_DATA_tb_top
add wave -noupdate -expand -group UART /sys_tb/dut/uart_dut/p_data_top
add wave -noupdate -expand -group UART /sys_tb/dut/uart_dut/BUSY_tb_top
add wave -noupdate -expand -group UART -radix binary /sys_tb/dut/uart_dut/RX/data_valid
add wave -noupdate -expand -group UART /sys_tb/dut/uart_dut/RX/P_DATA
add wave -noupdate -expand -group UART -color White -radix binary /sys_tb/dut/uart_dut/RX/parity_error
add wave -noupdate -expand -group UART -color White -radix binary /sys_tb/dut/uart_dut/RX/framing_error
add wave -noupdate -expand -group UART /sys_tb/dut/uart_dut/RX/data_valid
add wave -noupdate -expand -group UART -radix binary /sys_tb/dut/uart_dut/TX/PAR_TYP_tb
add wave -noupdate -expand -group UART /sys_tb/dut/uart_dut/RX/par_chk_en
add wave -noupdate -expand -group UART /sys_tb/dut/uart_dut/RX/bit_count
add wave -noupdate -expand -group UART /sys_tb/dut/uart_dut/RX/edge_count
add wave -noupdate -expand -group UART -radix binary /sys_tb/dut/uart_dut/RX/parity_type
add wave -noupdate -expand -group UART /sys_tb/dut/uart_dut/RX/stp_chk_en
add wave -noupdate -expand -group UART /sys_tb/dut/uart_dut/RX/sampled_bit
add wave -noupdate -expand -group UART -color Gray90 /sys_tb/dut/uart_dut/TX/TX_OUT_tb
add wave -noupdate -expand -group UART -color White /sys_tb/dut/uart_dut/TX/DATA_VALID_tb
add wave -noupdate -expand -group CONTROLL -color {Indian Red} /sys_tb/dut/controller_dut/wr_data
add wave -noupdate -expand -group CONTROLL /sys_tb/dut/controller_dut/current_state
add wave -noupdate -expand -group CONTROLL /sys_tb/dut/controller_dut/next_state
add wave -noupdate -expand -group CONTROLL /sys_tb/dut/controller_dut/data_valid_cntrl
add wave -noupdate -expand -group CONTROLL -color {Indian Red} /sys_tb/dut/controller_dut/addr
add wave -noupdate -expand -group CONTROLL /sys_tb/dut/controller_dut/wr_d
add wave -noupdate -expand -group CONTROLL /sys_tb/dut/controller_dut/wren
add wave -noupdate -expand -group CONTROLL /sys_tb/dut/controller_dut/rden
add wave -noupdate -expand -group CONTROLL /sys_tb/dut/controller_dut/wr_inc
add wave -noupdate -expand -group CONTROLL /sys_tb/dut/controller_dut/fifo_full
add wave -noupdate -expand -group CONTROLL /sys_tb/dut/controller_dut/rd_d
add wave -noupdate -expand -group CONTROLL -color {Indian Red} /sys_tb/dut/controller_dut/rd_d_valid
add wave -noupdate -expand -group CONTROLL -color {Indian Red} /sys_tb/dut/controller_dut/data_valid
add wave -noupdate -expand -group CONTROLL /sys_tb/dut/controller_dut/wr_inc
add wave -noupdate -expand -group DATA_SYNC -color Blue /sys_tb/dut/DATA_SYNC_dut/unsync_bus
add wave -noupdate -expand -group DATA_SYNC /sys_tb/dut/DATA_SYNC_dut/enable_pulse
add wave -noupdate -expand -group DATA_SYNC /sys_tb/dut/DATA_SYNC_dut/sync_enable
add wave -noupdate -expand -group DATA_SYNC -color Blue /sys_tb/dut/DATA_SYNC_dut/sync_bus
add wave -noupdate -expand -group DATA_SYNC /sys_tb/dut/DATA_SYNC_dut/sync_enable
add wave -noupdate -expand -group REG_FILE /sys_tb/dut/regfile_dut/Reg_File
add wave -noupdate -expand -group FIFO /sys_tb/dut/async_fifo_fifo/w_addr
add wave -noupdate -expand -group FIFO /sys_tb/dut/async_fifo_fifo/r_addr
add wave -noupdate -expand -group FIFO /sys_tb/dut/async_fifo_fifo/gray_rd_ptr
add wave -noupdate -expand -group FIFO /sys_tb/dut/async_fifo_fifo/gray_w_ptr
add wave -noupdate -expand -group FIFO /sys_tb/dut/async_fifo_fifo/i_r_inc
add wave -noupdate -expand -group FIFO /sys_tb/dut/async_fifo_fifo/i_w_inc
add wave -noupdate -expand -group FIFO -color Magenta /sys_tb/dut/async_fifo_fifo/o_empty
add wave -noupdate -expand -group ALU -color {Medium Aquamarine} /sys_tb/dut/ALU_dut/A
add wave -noupdate -expand -group ALU -color {Medium Aquamarine} /sys_tb/dut/ALU_dut/B
add wave -noupdate -expand -group ALU -color {Medium Aquamarine} /sys_tb/dut/ALU_dut/ALU_FUN
add wave -noupdate -expand -group ALU /sys_tb/dut/ALU_dut/ALU_OUT
add wave -noupdate -expand -group ALU /sys_tb/dut/ALU_dut/OUT_VALID
add wave -noupdate -expand -group TOP -color Violet /sys_tb/dut/out_fifo
add wave -noupdate -expand -group TOP /sys_tb/dut/wr_register_en
add wave -noupdate -expand -group TOP -color Violet /sys_tb/dut/in_fifo
add wave -noupdate -expand -group TOP /sys_tb/dut/rd_register_en
add wave -noupdate -expand -group TOP /sys_tb/dut/address_register
add wave -noupdate -expand -group TOP /sys_tb/dut/wr_register_data
add wave -noupdate -expand -group TOP /sys_tb/dut/rd_register_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1335825000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {1394156903 ps} {1427711335 ps}
