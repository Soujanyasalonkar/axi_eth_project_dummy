module axis_xgmii_rx_64 #(

parameter DATA_WIDTH = 64,

parameter KEEP_WIDTH = (DATA_WIDTH/8),

parameter CTRL_WIDTH = (DATA_WIDTH/8),

parameter PTP_TS_ENABLE = 0,

parameter PTP_TS_FMT_TOD = 1,

parameter PTP_TS_WIDTH=PTP_TS_FMT_TOD ? 96 : 64,

parameter USER_WIDTH = 8 

)
(
input clk,

input rst,

input xgmii_rxd,

input xgmii_rxc,

output m_axis_tdata,

output m_axis_tkeep,

output m_axis_tvalid,

output m_axis_tlast,

output m_axis_tuser,

output ptp_ts,

output cfg_rx_enable,

output start_packet,

output error_bad_frame,

output error_bad_fcs
);

endmodule:axis_xgmii_rx_64
