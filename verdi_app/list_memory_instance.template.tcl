#!/usr/bin/tclsh

source $env(NOVAS_HOME)/share/NPI/L1/TCL/npi_L1.tcl

# load the design database
#debImport chip_lib

set fp_ram [open "ram.log" "w"]
if {$fp_ram == ""} {
  puts "Can not open ram.log !"
}
set fp_rom [open "rom.log" "w"]
if {$fp_rom == ""} {
  puts "Can not open rom.log !"
}

::npi_L1::npi_find_inst_regex_dump "proj_top_th" "u_.*ram_\[0-9\]" $fp_ram
::npi_L1::npi_find_inst_regex_dump "proj_top_th" "u_rom_\[0-9\]"   $fp_rom

close $fp_ram
close $fp_rom

# Exit Verdi
#debExit

