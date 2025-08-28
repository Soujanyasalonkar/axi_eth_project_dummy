module eth_phy_10g_tx
 #(

 parameter DATA_WIDTH=64,

 parameter CTRL_WIDTH=(DATA_WIDTH/8),

 parameter HDR_WIDTH=2,

 parameter BIT_REVERSE=0,

 parameter SCRAMBLER_DISABLE=0,

 parameter PRBS31_ENABLE=0,

 parameter SERDES_PIPELINE=0

)

(

input clk,

input rst,

input xgmii_txd,

input xgmii_txc,

output serdes_tx_data,

output serdes_tx_hdr,

output tx_bad_block,

output cfg_tx_prbs31_enable

);
endmodule:eth_phy_10g_tx 
