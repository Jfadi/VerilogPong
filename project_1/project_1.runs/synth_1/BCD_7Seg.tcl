# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/hanh/FinalProject361/VerilogPong/project_1/project_1.cache/wt [current_project]
set_property parent.project_path C:/Users/hanh/FinalProject361/VerilogPong/project_1/project_1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys-a7-100t:part0:1.0 [current_project]
set_property ip_output_repo c:/Users/hanh/FinalProject361/VerilogPong/project_1/project_1.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib C:/Users/hanh/FinalProject361/VerilogPong/project_1/project_1.srcs/sources_1/new/BCD_7Seg.v
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/hanh/FinalProject361/VerilogPong/sources/NexysA7-100t.xdc
set_property used_in_implementation false [get_files C:/Users/hanh/FinalProject361/VerilogPong/sources/NexysA7-100t.xdc]


synth_design -top BCD_7Seg -part xc7a100tcsg324-1


write_checkpoint -force -noxdef BCD_7Seg.dcp

catch { report_utilization -file BCD_7Seg_utilization_synth.rpt -pb BCD_7Seg_utilization_synth.pb }
