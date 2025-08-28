// SPDX-License-Identifier: MIT
/*

Copyright (c) 2025 FPGA Ninja, LLC

Authors:
- Alex Forencich

*/

interface taxi_axis_if #(
    // Width of AXI stream interfaces in bits
    parameter DATA_WIDTH = 64,
    // tkeep signal width (bytes per cycle)
    parameter KEEP_WIDTH = ((DATA_WIDTH+7)/8),

    parameter CTRL_WIDTH = (DATA_WIDTH/8),
    // Use tkeep signal
    parameter logic KEEP_EN = KEEP_WIDTH > 1,
    // Use tstrb signal
    parameter logic STRB_EN = 1'b0,
    // Use tlast signal
    parameter logic LAST_EN = 1'b1,
    // Use tid signal
    parameter logic ID_EN = 0,
    // tid signal width
    parameter ID_W = 8,
    // Use tdest signal
    parameter logic DEST_EN = 0,
    // tdest signal width
    parameter DEST_W = 8,
    // Use tuser signal
    parameter logic USER_EN = 0,
    // tuser signal width
   // parameter USER_W = 1
   //
    parameter PTP_TS_ENABLE = 0,
    parameter PTP_TAG_WIDTH = 16,
    parameter PTP_TS_FMT_TOD = 1,
    parameter PTP_TS_WIDTH = PTP_TS_FMT_TOD ? 96 : 64,
   parameter USER_W = (PTP_TS_ENABLE ? PTP_TS_WIDTH : 0) + 1

)
/*  -----------------compile error (grp1)-----------------------
(input aclk,input aresetn);
    logic [DATA_W-1:0] tdata;
    logic [KEEP_W-1:0] tkeep;
    logic [KEEP_W-1:0] tstrb;
    logic [ID_W-1:0] tid;
    logic [DEST_W-1:0] tdest;
    logic [USER_W-1:0] tuser;
    logic tlast;
    logic tvalid;
    logic tready;
*/



  
(input bit tx_clk,rx_clk, tx_rst,rx_rst);

    logic [DATA_WIDTH-1:0] tdata;
    logic [KEEP_WIDTH-1:0] tkeep;
    logic [KEEP_WIDTH-1:0] tstrb;
    logic [ID_W-1:0] tid;
    logic [DEST_W-1:0] tdest;
    logic [USER_W-1:0] tuser;
    logic tlast;
    logic tvalid;
    logic tready;
    
/*
    logic                           rx_clk;
    logic                           rx_rst;
    logic                           tx_clk;
    logic                          tx_rst;
    */

    /*
     * AXI input
     */
    logic   [DATA_WIDTH-1:0]        tx_axis_tdata;
    logic   [KEEP_WIDTH-1:0]        tx_axis_tkeep;
    logic                           tx_axis_tvalid;
    logic                         tx_axis_tready;
    logic                           tx_axis_tlast;
    logic   [USER_W-1:0]     tx_axis_tuser;

    /*
     * AXI output
     */
    logic  [DATA_WIDTH-1:0]        rx_axis_tdata;
    logic  [KEEP_WIDTH-1:0]        rx_axis_tkeep;
    logic                         rx_axis_tvalid;
    logic                          rx_axis_tlast;
    logic  [USER_W-1:0]     rx_axis_tuser;

    /*
     * XGMII interface
     */
    logic  [DATA_WIDTH-1:0]        xgmii_rxd;
    logic   [CTRL_WIDTH-1:0]        xgmii_rxc;
    logic  [DATA_WIDTH-1:0]        xgmii_txd;
    logic  [CTRL_WIDTH-1:0]        xgmii_txc;

    /*
     * PTP
     */
    logic   [PTP_TS_WIDTH-1:0]      tx_ptp_ts;
    logic   [PTP_TS_WIDTH-1:0]      rx_ptp_ts;
    logic  [PTP_TS_WIDTH-1:0]      tx_axis_ptp_ts;
    logic  [PTP_TAG_WIDTH-1:0]  tx_axis_ptp_ts_tag;
    logic                          tx_axis_ptp_ts_valid;

    /*
     * Link-level Flow Control (LFC) (IEEE 802.3 annex 31B PAUSE)
     */
    logic                          tx_lfc_req;
    logic                           tx_lfc_resend;
    logic                           rx_lfc_en;
    logic                         rx_lfc_req;
    logic                           rx_lfc_ack;

    /*
     * Priority Flow Control (PFC) (IEEE 802.3 annex 31D PFC)
     */
    logic  [7:0]                   tx_pfc_req;
    logic                          tx_pfc_resend;
    logic   [7:0]                   rx_pfc_en;
    logic [7:0]                   rx_pfc_req;
    logic  [7:0]                   rx_pfc_ack;

    /*
     * Pause interface
     */
    logic                          tx_lfc_pause_en;
    logic                         tx_pause_req;
    logic                         tx_pause_ack;

   
    
   logic [1:0]                   tx_start_packet;
    logic                         tx_error_underflow;
    logic [1:0]                   rx_start_packet;
    logic                         rx_error_bad_frame;
    logic                         rx_error_bad_fcs;

     /*
     * Status
     
    output wire                         stat_tx_mcf,
    output wire                         stat_rx_mcf,
    output wire                         stat_tx_lfc_pkt,
    output wire                         stat_tx_lfc_xon,
    output wire                         stat_tx_lfc_xoff,
    output wire                         stat_tx_lfc_paused,
    output wire                         stat_tx_pfc_pkt,
    output wire [7:0]                   stat_tx_pfc_xon,
    output wire [7:0]                   stat_tx_pfc_xoff,
    output wire [7:0]                   stat_tx_pfc_paused,
    output wire                         stat_rx_lfc_pkt,
    output wire                         stat_rx_lfc_xon,
    output wire                         stat_rx_lfc_xoff,
    output wire                         stat_rx_lfc_paused,
    output wire                         stat_rx_pfc_pkt,
    output wire [7:0]                   stat_rx_pfc_xon,
    output wire [7:0]                   stat_rx_pfc_xoff,
    output wire [7:0]                   stat_rx_pfc_paused,
    */
    

    /*
     * Configuration
     */
    logic [7:0]                   cfg_ifg;
    logic                          cfg_tx_enable;
    logic                         cfg_rx_enable;
    logic  [47:0]                  cfg_mcf_rx_eth_dst_mcast;
    logic                          cfg_mcf_rx_check_eth_dst_mcast;
    logic  [47:0]                  cfg_mcf_rx_eth_dst_ucast;
    logic                          cfg_mcf_rx_check_eth_dst_ucast;
    logic  [47:0]                  cfg_mcf_rx_eth_src;
    logic                          cfg_mcf_rx_check_eth_src;
    logic  [15:0]                  cfg_mcf_rx_eth_type;
    logic  [15:0]                  cfg_mcf_rx_opcode_lfc;
    logic                          cfg_mcf_rx_check_opcode_lfc;
    logic  [15:0]                  cfg_mcf_rx_opcode_pfc;
    logic                          cfg_mcf_rx_check_opcode_pfc;
    logic                          cfg_mcf_rx_forward;
    logic                          cfg_mcf_rx_enable;
    logic  [47:0]                  cfg_tx_lfc_eth_dst;
    logic  [47:0]                  cfg_tx_lfc_eth_src;
    logic  [15:0]                  cfg_tx_lfc_eth_type;
    logic  [15:0]                  cfg_tx_lfc_opcode;
    logic                          cfg_tx_lfc_en;
    logic  [15:0]                  cfg_tx_lfc_quanta;
    logic  [15:0]                  cfg_tx_lfc_refresh;
    logic  [47:0]                  cfg_tx_pfc_eth_dst;
    logic  [47:0]                  cfg_tx_pfc_eth_src;
    logic  [15:0]                  cfg_tx_pfc_eth_type;
    logic  [15:0]                  cfg_tx_pfc_opcode;
    logic                          cfg_tx_pfc_en;
    logic  [8*16-1:0]              cfg_tx_pfc_quanta;
    logic  [8*16-1:0]              cfg_tx_pfc_refresh;
    logic  [15:0]                  cfg_rx_lfc_opcode;
    logic                          cfg_rx_lfc_en;
    logic  [15:0]                  cfg_rx_pfc_opcode;
    logic                          cfg_rx_pfc_en;



/*
  logic [DATA_WIDTH-1:0]        xgmii_rxd;
  logic [CTRL_WIDTH-1:0]        xgmii_rxc;
  logic [DATA_WIDTH-1:0]        xgmii_txd;
  logic [CTRL_WIDTH-1:0]        xgmii_txc;
*/

    modport src (
        output tdata,
        output tkeep,
        output tstrb,
        output tid,
        output tdest,
        output tuser,
        output tlast,
        output tvalid,
        input  tready
    );

    modport snk (
        input  tdata,
        input  tkeep,
        input  tstrb,
        input  tid,
        input  tdest,
        input  tuser,
        input  tlast,
        input  tvalid,
        output tready
    );

    modport mon (
        input  tdata,
        input  tkeep,
        input  tstrb,
        input  tid,
        input  tdest,
        input  tuser,
        input  tlast,
        input  tvalid,
        input  tready
    );

endinterface
