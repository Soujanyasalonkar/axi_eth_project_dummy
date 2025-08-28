module axis_xgmii_tx_64 #(
parameter DATA_WIDTH = 64,

parameter KEEP_WIDTH = (DATA_WIDTH/8),

parameter CTRL_WIDTH = (DATA_WIDTH/8),

parameter ENABLE_PADDING = 1,

parameter ENABLE_DIC = 1,

parameter MIN_FRAME_LENGTH = 64,

parameter PTP_TS_ENABLE = 0,

parameter PTP_TS_FMT_TOD = 1,

parameter PTP_TS_WIDTH = PTP_TS_FMT_TOD ? 96 : 64,

parameter PTP_TS_CTRL_IN_TUSER = 0,

parameter PTP_TAG_ENABLE = PTP_TS_ENABLE,

parameter PTP_TAG_WIDTH = 16,

parameter USER_WIDTH = 8
)
(
 input clk,

 input rst,

 input s_axis_tdata,

 input s_axis_tkeep,

 input s_axis_tvalid,

 input s_axis_tready,

 input s_axis_tlast,

 input s_axis_tuser,

 output xgmii_txd,

 output xgmii_txc,

 output ptp_ts,

 output m_axis_ptp_ts,

 output m_axis_ptp_ts_tag,

 output m_axis_ptp_ts_valid,

 output cfg_ifg,

 output cfg_tx_enable,

 output start_packet,

 output error_underflow
);

endmodule:axis_xgmii_tx_64
