module eth_phy_10g_rx #
(
  parameter DATA_WIDTH = 64,
  parameter CTRL_WIDTH = (DATA_WIDTH/8),
  parameter BIT_REVERSE = 0,
  parameter SCRAMBLER_DISABLE = 0,
  parameter PRBS31_ENABLE = 0,
  parameter SERDES_PIPELINE = 0,
  parameter BITSLIP_HIGH_CYCLES = 1,
  parameter BITSLIP_LOW_CYCLES = 8,
  parameter COUNT_125US =  125000/6.4 
)
(

input clk,
input rst,

output xgmii_rxd,
output xgmii_rxc,
input serdes_rx_data,
input serdes_rx_hdr,
input serdes_rx_bitslip,
input serdes_rx_reset_req,
input rx_error_count,
input rx_bad_block,
input rx_sequence_error,
input rx_block_lock,
input rx_high_ber,
input rx_status,
input cfg_rx_prbs31_enable

);

endmodule:eth_phy_10g_rx
