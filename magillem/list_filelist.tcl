#!/usr/bin/tclsh

set subsys dbg_top

package require project
package require component
package require design
package require busdefinition
package require abstractiondefinition
package apirtl

set PROJ_ROOT $env(PROJ_ROOT)

######

set component_list [project::getResourceList component]
for {set i 0} {$i < [llength $component_list]} {incr i} {
  set component [lindex [lindex $component_list $i] 2]
  component::setCurrentComponent $component
  puts "Component: $component"
  set filesetName [component::getElementList fileset]
  puts [component::getElementProperty fileset $filesetName file_list]
}
