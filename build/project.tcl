set projDir "/media/share/Alchitry/buttonConditionerTest/build/vivado"
set projName "buttonConditionerTest"
set topName top
set device xc7a35tftg256-1
if {[file exists "$projDir"]} { file delete -force "$projDir" }
create_project $projName "$projDir" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "/media/share/Alchitry/buttonConditionerTest/build/source/alchitryTop.sv" "/media/share/Alchitry/buttonConditionerTest/build/source/resetConditioner.sv" "/media/share/Alchitry/buttonConditionerTest/build/source/pipeline.sv" "/media/share/Alchitry/buttonConditionerTest/build/source/buttonConditioner.sv" ]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set xdcSources [list "/media/share/Alchitry/buttonConditionerTest/build/constraint/alchitry.xdc" "/media/share/Alchitry/buttonConditionerTest/build/constraint/au_props.xdc" ]
read_xdc $xdcSources
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1 -jobs 8
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
