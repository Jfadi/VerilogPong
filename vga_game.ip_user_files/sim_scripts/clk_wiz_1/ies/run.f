-makelib ies/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2016.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "C:/Xilinx/Vivado/2016.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../ip/clk_wiz_1/clk_wiz_1_clk_wiz.v" \
  "../../../ip/clk_wiz_1/clk_wiz_1.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

