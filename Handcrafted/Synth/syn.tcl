#	Yosys script
#	The main purpose is to elaborate the design only!	
#
#   Author: Mohamed Shalan (mshalan@aucegypt.edu)
#

yosys -import
set PDK_PATH /ef/tech/SW/sky130A
set DESIGN 	DFFRAM
set SCL		$PDK_PATH/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

read_liberty -lib -ignore_miss_dir -setattr blackbox $SCL
read_verilog  DFFRAMBB.v $DESIGN.v

hierarchy -check -top $DESIGN

synth -top $DESIGN -flatten

splitnets
opt_clean -purge

write_verilog -noattr -noexpr -nodec $DESIGN.gl.v
stat -top $DESIGN -liberty $SCL > $DESIGN.stats.txt

exit

