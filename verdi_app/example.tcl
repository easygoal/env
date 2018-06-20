#!/usr/bin/tclsh

proc cb_func_collect_obj { hdl cb } {
  upvar $cb pHdLisa
  lappend   pHdList $hdl
  npi_set_permanent_handle -object $hdl
}

proc dump_handle_result { modHdlList portHdlList } {
  set modListLen  [llength $modHdlList]
  set portListLen [llength $portHdlList]
  for {set i 0} {$i < $modHdlList} {incr i} {
    ::npi_L1::npi_sv_ut_dump_hdl_info [lindex $modHdlList $i] stdout
  }
  for {set i 0} {$i < $portHdlList} {incr i} {
    ::npi_L1::npi_sv_ut_dump_hdl_info [lindex $portHdlList $i] stdout
  }
  puts "Found $modListLen modules and $portListLen ports"
}

set modHdlList ""
set portHdlList ""
::npi_L1::npi_hier_tree_trv_register_cb "npiModule" "cb_func_collect_obj" "modHdlList"
::npi_L1::npi_hier_tree_trv_register_cb "npiPort"   "cb_func_collect_obj" "portHdlList"
::npi_L1::npi_hier_tree_trv "proj_top_th"
dump_handle_result $modHdlList $portHdlList

npi_release_all_handles

