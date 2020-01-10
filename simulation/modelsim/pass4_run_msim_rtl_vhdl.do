transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {F:/Documents/PASSCODE_FPGA/switch.vhd}
vcom -93 -work work {F:/Documents/PASSCODE_FPGA/pass4.vhd}
vcom -93 -work work {F:/Documents/PASSCODE_FPGA/leddec.vhd}
vcom -93 -work work {F:/Documents/PASSCODE_FPGA/clockDown.vhd}
vcom -93 -work work {F:/Documents/PASSCODE_FPGA/control.vhd}
vcom -93 -work work {F:/Documents/PASSCODE_FPGA/disp_ctl.vhd}
vcom -93 -work work {F:/Documents/PASSCODE_FPGA/changer.vhd}
vcom -93 -work work {F:/Documents/PASSCODE_FPGA/datapath.vhd}
vcom -93 -work work {F:/Documents/PASSCODE_FPGA/validation.vhd}

