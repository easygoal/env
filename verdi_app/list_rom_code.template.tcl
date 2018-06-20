#!/usr/bin/tclsh

source $env(NOVAS_HOME)/share/NPI/L1/TCL/npi_L1.tcl

# load the design database
#debImport chip_lib

set fp_rom [open "load_rom.tcl" "w"]
if {$fp_rom == ""} {
  puts "Can not open load_rom.tcl !"
}

proc cb_func_collect_obj { hdl cb } {
  upvar $cb pHdList
  lappend   pHdList $hdl
  npi_set_permanent_handle -object $hdl
}

proc get_handle_result { modHdlList fp_rom } {
  set modListLen [llength $modHdlList]
  for {set i 0} {$i < $modListLen} {incr i} {
    set modFullName [npi_get_str -property npiFullName -object [lindex $modHdlList $i]]
    set modDefFile  [npi_get_str -property npiDefFile  -object [lindex $modHdlList $i]]
    if { [regexp "u_rom_\[0-9\]" $modFullName ] } {
      puts $fp_rom "set ROM_INST_$i $modFullName"
      puts $fp_rom "set ROM_CODE_$i $modDefFile "
    }
  }
}

set modHdlList ""
::npi_L1::npi_hier_tree_trv_register_cb "npiModule" "cb_func_collect_obj" "modHdlList"
::npi_L1::npi_hier_tree_trv "proj_top_th"
get_handle_result $modHdlList $fp_rom

npi_release_all_handles

close $fp_rom

# Exit Verdi
#debExit

