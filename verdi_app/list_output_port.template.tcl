#!/usr/bin/tclsh

source $env(NOVAS_HOME)/share/NPI/L1/TCL/npi_L1.tcl

# load the design database
#debImport chip_lib

set fp [open "output.log" "w"]
if {$fp == ""} {
  puts "Can not open output.log !"
}

set module_list {
  proj_top_th.chip_top.dut.u_digital_top.u_sys_ap.u_ap_top.u_vdsp_wrap
  proj_top_th.chip_top.dut.u_digital_top.u_sys_ap.u_ap_top.u_vsp_wrap
  proj_top_th.chip_top.dut.u_digital_top.u_sys_ap.u_ap_top.u_disp_wrap
  proj_top_th.chip_top.dut.u_digital_top.u_sys_ap
  proj_top_th.chip_top.dut.u_digital_top.u_sys_apcpu
  proj_top_th.chip_top.dut.u_digital_top.u_sys_ap_gpu
  proj_top_th.chip_top.dut.u_digital_top.u_sys_ap_mm
  proj_top_th.chip_top.dut.u_digital_top.u_sys_ese
  proj_top_th.chip_top.dut.u_digital_top.u_sys_cp_aud
  proj_top_th.chip_top.dut.u_digital_top.u_sys_cp_pub
  proj_top_th.chip_top.dut.u_digital_top.u_sys_cp_wtl
  proj_top_th.chip_top.dut.u_digital_top.u_ai_top_pwr_wrap
  proj_top_th.chip_top.dut.u_digital_top.u_ipa_top_pwr_wrap
}

foreach modHier $module_list {
	set modHdl [npi_handle_by_name -name $modHier -scope ""]
	set modFullName [npi_get_str -property npiFullName -object $modHdl]
	
	#Traverse port
	set portItr [npi_iterate -type npiPort -refHandle $modHdl]
	while { [set portHdl [npi_scan -iterate $portItr]] != ""} {
		set portName       [npi_get_str -property npiName      -object $portHdl ]
		set portDirection  [npi_get_str -property npiDirection -object $portHdl ]
		set portSize       [npi_get     -property npiSize      -object $portHdl ]
		if { $portDirection == "npiOutput" } {
			if { $portSize == 1} {
				puts $fp "$modFullName.$portName"
			} else {
        puts $fp "$modFullName.$portName\[[ expr {$portSize-1} ]:0\]"
		  }
		}
  }
}

close $fp

# Exit Verdi
#debExit

