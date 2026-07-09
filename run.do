vlib work 
vlog *.*v 
vsim -voptargs=+acc work.sys_tb
do wave.do
run -all