####################################################################################
# Section 2 : Clocks Relationship
####################################################################################


set period [expr 1000/3.686/2]
set clk [expr 1000/3.686]
# ===== Master clocks =====
create_clock -name CLK_REF  -period 100 -waveform {0 50}      [get_ports REF_CLK]
set_clock_uncertainty -setup 0.2 [get_clocks CLK_REF]
set_clock_uncertainty -hold  0.1 [get_clocks CLK_REF]
set_clock_transition 0.5          [get_clocks CLK_REF]
set_clock_latency    0            [get_clocks CLK_REF]

create_clock -name CLK_UART -period $clk -waveform {0 135.6483993}   [get_ports UART_CLK]
set_clock_uncertainty -setup 0.2 [get_clocks CLK_UART]
set_clock_uncertainty -hold  0.1 [get_clocks CLK_UART]
set_clock_transition 0.5          [get_clocks CLK_UART]
set_clock_latency    0            [get_clocks CLK_UART]

# ===== Generated clocks =====

create_generated_clock -name CLK_RX -master_clock CLK_UART -source [get_ports UART_CLK] \
    -divide_by 1  [get_pins clk_div_rx_dut/o_div_clk]
set_clock_uncertainty -setup 0.2 [get_clocks CLK_RX]
set_clock_uncertainty -hold  0.1 [get_clocks CLK_RX]



create_generated_clock -name CLK_TX -master_clock CLK_UART -source [get_ports UART_CLK] \
    -divide_by 32 [get_pins clk_div_tx_dut/o_div_clk]
set_clock_uncertainty -setup 0.2 [get_clocks CLK_TX]
set_clock_uncertainty -hold  0.1 [get_clocks CLK_TX]



create_generated_clock -name CLK_ALU -master_clock CLK_REF -source [get_ports REF_CLK] \
    -divide_by 1  [get_pins clk_gate_dut/GATED_CLK]
set_clock_uncertainty -setup 0.2 [get_clocks CLK_ALU]
set_clock_uncertainty -hold  0.1 [get_clocks CLK_ALU]

set_clock_groups -asynchronous -group [get_clocks "CLK_REF CLK_ALU"] -group [get_clocks "CLK_RX CLK_TX CLK_UART"] 
set_multicycle_path -setup 32 -from CLK_TX -to CLK_UART
set_multicycle_path -setup 31 -from CLK_TX -to CLK_UART

set_dont_touch_network [get_clocks {CLK_UART CLK_REF CLK_TX CLK_RX CLK_ALU}]
set_dont_touch_network [get_ports  RST_N]

####################################################################################
# Section 3 : I/O Delays
####################################################################################
set delay [expr 0.2*1000/3.686]
set delays [expr 0.2*1000*32/3.686]
set_input_delay  $delay   -clock CLK_RX [get_ports UART_RX_IN]
set_output_delay $delays -clock CLK_TX [get_ports UART_TX_O]

####################################################################################
# Section 4 : Driving cells
####################################################################################
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y \
    [get_ports UART_RX_IN]

####################################################################################
# Section 5 : Output load
####################################################################################
set_load 0.1 [get_ports UART_TX_O]


set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" \
                         -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" \
			 -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" \
			 -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"

set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c
