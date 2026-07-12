###################################################################

# Created by write_sdc on Mon Sep 29 21:07:15 2025

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -max_library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -min scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c -min_library scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c
set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports UART_RX_IN]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports SE]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {SI[2]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {SI[1]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {SI[0]}]
set_load -pin_load 0.1 [get_ports UART_TX_O]
set_load -pin_load 0.1 [get_ports {SO[2]}]
set_load -pin_load 0.1 [get_ports {SO[1]}]
set_load -pin_load 0.1 [get_ports {SO[0]}]
set_case_analysis 1 [get_ports test_mode]
create_clock [get_ports REF_CLK]  -name CLK_REF  -period 100  -waveform {0 50}
set_clock_latency 0  [get_clocks CLK_REF]
set_clock_uncertainty -setup 0.2  [get_clocks CLK_REF]
set_clock_uncertainty -hold 0.1  [get_clocks CLK_REF]
set_clock_transition -min -fall 0.5 [get_clocks CLK_REF]
set_clock_transition -min -rise 0.5 [get_clocks CLK_REF]
set_clock_transition -max -fall 0.5 [get_clocks CLK_REF]
set_clock_transition -max -rise 0.5 [get_clocks CLK_REF]
create_clock [get_ports UART_CLK]  -name CLK_UART  -period 271.297  -waveform {0 135.648}
set_clock_latency 0  [get_clocks CLK_UART]
set_clock_uncertainty -setup 0.2  [get_clocks CLK_UART]
set_clock_uncertainty -hold 0.1  [get_clocks CLK_UART]
set_clock_transition -min -fall 0.5 [get_clocks CLK_UART]
set_clock_transition -min -rise 0.5 [get_clocks CLK_UART]
set_clock_transition -max -fall 0.5 [get_clocks CLK_UART]
set_clock_transition -max -rise 0.5 [get_clocks CLK_UART]
create_generated_clock [get_pins clk_div_rx_dut/o_div_clk]  -name CLK_RX  -source [get_ports UART_CLK]  -master_clock CLK_UART  -divide_by 1  -add
set_clock_uncertainty -setup 0.2  [get_clocks CLK_RX]
set_clock_uncertainty -hold 0.1  [get_clocks CLK_RX]
create_generated_clock [get_pins clk_div_tx_dut/o_div_clk]  -name CLK_TX  -source [get_ports UART_CLK]  -master_clock CLK_UART  -divide_by 32  -add
set_clock_uncertainty -setup 0.2  [get_clocks CLK_TX]
set_clock_uncertainty -hold 0.1  [get_clocks CLK_TX]
create_generated_clock [get_pins clk_gate_dut/GATED_CLK]  -name CLK_ALU  -source [get_ports REF_CLK]  -master_clock CLK_REF  -divide_by 1  -add
set_clock_uncertainty -setup 0.2  [get_clocks CLK_ALU]
set_clock_uncertainty -hold 0.1  [get_clocks CLK_ALU]
create_clock [get_ports scan_clk]  -name S_CLK  -period 271.297  -waveform {0 135.648}
set_clock_latency 0  [get_clocks S_CLK]
set_clock_uncertainty -setup 0.2  [get_clocks S_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks S_CLK]
set_clock_transition -min -fall 0.5 [get_clocks S_CLK]
set_clock_transition -min -rise 0.5 [get_clocks S_CLK]
set_clock_transition -max -fall 0.5 [get_clocks S_CLK]
set_clock_transition -max -rise 0.5 [get_clocks S_CLK]
set_multicycle_path 31 -setup -from [get_clocks CLK_TX] -to [get_clocks CLK_UART]
set_input_delay -clock CLK_RX  54.2594  [get_ports UART_RX_IN]
set_input_delay -clock CLK_RX  54.2594  [get_ports {SI[2]}]
set_input_delay -clock CLK_RX  54.2594  [get_ports {SI[1]}]
set_input_delay -clock CLK_RX  54.2594  [get_ports {SI[0]}]
set_input_delay -clock CLK_RX  54.2594  [get_ports SE]
set_output_delay -clock CLK_TX  1736.3  [get_ports UART_TX_O]
set_output_delay -clock CLK_TX  1736.3  [get_ports {SO[2]}]
set_output_delay -clock CLK_TX  1736.3  [get_ports {SO[1]}]
set_output_delay -clock CLK_TX  1736.3  [get_ports {SO[0]}]
set_clock_groups -asynchronous -name CLK_REF_1 -group [list [get_clocks CLK_REF] [get_clocks CLK_ALU]] -group [list [get_clocks CLK_RX] [get_clocks CLK_TX] [get_clocks CLK_UART]] -group [get_clocks S_CLK]
