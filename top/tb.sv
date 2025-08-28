// Code your testbench here
// or browse Examples

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "../src/rtl/eth_mac_10g/eth_mac_10g.v"
//`include "../src/rtl/eth_mac_10g/axis_xgmii_rx_32.v"
`include "../src/rtl/eth_mac_10g/axis_xgmii_rx_64.v"
//`include "../src/rtl/eth_mac_10g/axis_xgmii_tx_32.v"
`include "../src/rtl/eth_mac_10g/axis_xgmii_tx_64.v"
`include "../src/rtl/eth_mac_10g/taxi_lfsr.v"
`include "../src/rtl/eth_mac_10g/mac_ctrl_rx.v"
`include "../src/rtl/eth_mac_10g/mac_ctrl_tx.v"
//`include "../src/rtl/eth_mac_10g/mac_pause_ctrl_rx.v"
//`include "../src/rtl/eth_mac_10g/mac_pause_ctrl_tx.v"

`include "../src/rtl/eth_mac_10g/axis_if.sv"
`include "eth_mac_10g_seq_item.sv"
`include "eth_mac_10g_seq.sv"
`include "eth_mac_10g_sequencer.sv"
`include "eth_mac_10g_driver.sv"
`include "eth_mac_10g_monitor.sv"
`include "eth_mac_10g_agent.sv"
`include "eth_mac_10g_env.sv"
`include "eth_mac_10g_test.sv"



 
 // parameter DATA_WIDTH = 64;
 // parameter KEEP_WIDTH = (DATA_WIDTH/8);
 // parameter CTRL_WIDTH = (DATA_WIDTH/8); 


          parameter ID_W = 8;
          parameter DATA_WIDTH = 64;
          parameter HDR_WIDTH = 2;
          parameter KEEP_WIDTH = (DATA_WIDTH/8);
          parameter STRB_EN ='b0;
          parameter LAST_EN = 'b1;
          parameter ID_EN = 'b0;
          parameter DEST_EN='b0;
          parameter DEST_W=8;
          parameter USER_EN=0;

            parameter KEEP_EN = KEEP_WIDTH > 1;
          parameter CTRL_WIDTH = (DATA_WIDTH/8);
          parameter ENABLE_PADDING = 1;
          parameter ENABLE_DIC = 1;
          parameter MIN_FRAME_LENGTH = 64;
          parameter PTP_TS_ENABLE = 0;
          parameter PTP_TS_FMT_TOD = 1;
          parameter PTP_TS_WIDTH = PTP_TS_FMT_TOD ? 96 : 64;

          parameter USER_W = (PTP_TS_ENABLE ? PTP_TS_WIDTH : 0) + 1;

          parameter TX_PTP_TS_CTRL_IN_TUSER = 0;
          parameter TX_PTP_TAG_ENABLE = PTP_TS_ENABLE;
          parameter TX_PTP_TAG_WIDTH = 16;
          parameter TX_USER_WIDTH = (PTP_TS_ENABLE ? (TX_PTP_TAG_ENABLE ? TX_PTP_TAG_WIDTH : 0) + (TX_PTP_TS_CTRL_IN_TUSER ? 1 : 0) : 0) + 1;
          parameter RX_USER_WIDTH = (PTP_TS_ENABLE ? PTP_TS_WIDTH : 0) + 1;
          parameter PFC_ENABLE = 0;
          parameter PAUSE_ENABLE = PFC_ENABLE;



 
module tb;
 
//bit tx_clk;
//bit tx_rst;
//bit rx_clk;
//bit rx_rst;
 bit tb_rx_clk;
 bit tb_rx_rst;
 bit tb_tx_clk;
 bit tb_tx_rst;


 bit aclk;
 bit aresetn;

 // taxi_axis_if axis_if(tx_clk,rx_clk,tx_rst,rx_rst);

  taxi_axis_if 
 #( .DATA_WIDTH(DATA_WIDTH),
    // tkeep signal width (bytes per cycle)
    .KEEP_WIDTH(KEEP_WIDTH),
    // Use tkeep signal
    .KEEP_EN(KEEP_EN),
    // Use tstrb signal
    .STRB_EN(STRB_EN),
    // Use tlast signal
    .LAST_EN(LAST_EN),
    // Use tid signal
    .ID_EN(ID_EN),
    // tid signal width
    .ID_W(ID_W),
    // Use tdest signal
    .DEST_EN(DEST_EN),
    // tdest signal width
    .DEST_W(DEST_W),
    // Use tuser signal
    .USER_EN(USER_EN),
    // tuser signal width
    .USER_W(USER_W)
)
//axis_if(aclk,aresetn);
axis_if(tb_tx_clk,tb_rx_clk,tb_tx_rst,tb_rx_rst);


 
  eth_mac_10g #(.DATA_WIDTH(DATA_WIDTH),

               .KEEP_WIDTH(DATA_WIDTH/8),

               .CTRL_WIDTH(DATA_WIDTH/8),

               .ENABLE_PADDING(1),

               .ENABLE_DIC(1),

               .MIN_FRAME_LENGTH(64),

               .PTP_TS_ENABLE(0),

               .PTP_TS_FMT_TOD(1),

               .PTP_TS_WIDTH(96),

               .TX_PTP_TS_CTRL_IN_TUSER(0),

               .TX_PTP_TAG_ENABLE(0),

               .TX_PTP_TAG_WIDTH(16),

               .TX_USER_WIDTH(1),

               .RX_USER_WIDTH(1),

               .PFC_ENABLE(0),

               .PAUSE_ENABLE(0)

)dut
/*
                   (
                   .tx_clk(tb_tx_clk),
                   .tx_rst(tb_tx_rst),
                   .rx_clk(tb_rx_clk),
                   .rx_rst(tb_rx_rst),
                   .tx_axis_tdata(axis_if.tdata),
                   .tx_axis_tkeep(axis_if.tkeep),
                   .tx_axis_tvalid(axis_if.tvalid),
                   .tx_axis_tready(axis_if.tready),
                   .tx_axis_tuser(axis_if.tuser),
                   .xgmii_rxd(axis_if.xgmii_rxd),
                   .xgmii_rxc(axis_if.xgmii_rxc),
                   .xgmii_txd(axis_if.xgmii_txd),
                   .xgmii_txc(axis_if.xgmii_txc)

                   
                   
                  );*/

                 (
                   .tx_clk(tb_tx_clk),
                   .tx_rst(tb_tx_rst),
                   .rx_clk(tb_rx_clk),
                   .rx_rst(tb_rx_rst),

                   .tx_axis_tdata(axis_if.tx_axis_tdata),                  
.tx_axis_tkeep(axis_if.tx_axis_tkeep),
.tx_axis_tvalid(axis_if.tx_axis_tvalid),
.tx_axis_tready(axis_if.tx_axis_tready),
.tx_axis_tlast(axis_if.tx_axis_tlast),
.tx_axis_tuser(axis_if.tx_axis_tuser),

//AXI o/p
  .rx_axis_tdata(axis_if.rx_axis_tdata),
  .rx_axis_tkeep(axis_if.rx_axis_tkeep),
  .rx_axis_tvalid(axis_if.rx_axis_tvalid),
  .rx_axis_tlast(axis_if.rx_axis_tlast),
  .rx_axis_tuser(axis_if.rx_axis_tuser),

 //XGMII interface

  .xgmii_rxd(axis_if.xgmii_rxd),
  .xgmii_rxc(axis_if.xgmii_rxc),
  .xgmii_txd(axis_if.xgmii_txd),
  .xgmii_txc(axis_if.xgmii_txc),

  //PTP related signals //To Check
  .tx_ptp_ts(axis_if.tx_ptp_ts),
  .rx_ptp_ts(axis_if.rx_ptp_ts),
  .tx_axis_ptp_ts(axis_if.tx_axis_ptp_ts),
  .tx_axis_ptp_ts_tag(axis_if.tx_axis_ptp_ts_tag),
  .tx_axis_ptp_ts_valid(axis_if.tx_axis_ptp_ts_valid),

  //Link Flow Control Signals
  .tx_lfc_req(axis_if.tx_lfc_req),
  .tx_lfc_resend(axis_if.tx_lfc_resend),
  .rx_lfc_en(axis_if.rx_lfc_en),
  .rx_lfc_req(axis_if.rx_lfc_req),
  .rx_lfc_ack(axis_if.rx_lfc_ack), 

  //Priority Flow Control Signals
  .tx_pfc_req(axis_if.tx_pfc_req),
  .tx_pfc_resend(axis_if.tx_pfc_resend),
  .rx_pfc_en(axis_if.rx_pfc_en),
  .rx_pfc_req(axis_if.rx_pfc_req),
  .rx_pfc_ack(axis_if.rx_pfc_ack),

  // Pause Related Signals 
  .tx_lfc_pause_en(axis_if.tx_lfc_pause_en),
  .tx_pause_req(axis_if.tx_pause_req),
  .tx_pause_ack(axis_if.tx_pause_ack),
 
  //Tx-Rx packet related 
  .tx_start_packet(axis_if.tx_start_packet),
  .tx_error_underflow(axis_if.tx_error_underflow),
  .rx_start_packet(axis_if.rx_start_packet),
  .rx_error_bad_frame(axis_if.rx_error_bad_frame),
  .rx_error_bad_fcs(axis_if.rx_error_bad_fcs),

  /*
// Status
  .stat_tx_mcf(stat_tx_mcf),
  .stat_rx_mcf(stat_rx_mcf),
  .stat_tx_lfc_pkt(stat_tx_lfc_pkt),
  .stat_tx_lfc_xon(stat_tx_lfc_xon),
  .stat_tx_lfc_xoff(stat_tx_lfc_xoff),
  .stat_tx_lfc_paused(stat_tx_lfc_paused),
  .stat_tx_pfc_pkt(stat_tx_pfc_pkt),
  .stat_tx_pfc_xon(stat_tx_pfc_xon),
  .stat_tx_pfc_xoff(stat_tx_pfc_xoff),
  .stat_tx_pfc_paused(stat_tx_pfc_paused),
  .stat_rx_lfc_pkt(stat_rx_lfc_pkt),
  .stat_rx_lfc_xon(stat_rx_lfc_xon),
  .stat_rx_lfc_xoff(stat_rx_lfc_xoff),
  .stat_rx_lfc_paused(stat_rx_lfc_paused),
  .stat_rx_pfc_pkt(stat_rx_pfc_pkt),
  .stat_rx_pfc_xon(stat_rx_pfc_xon),
  .stat_rx_pfc_xoff(stat_rx_pfc_xoff),
  .stat_rx_pfc_paused(stat_rx_pfc_paused),

  */
/*
*Configuration
*/
 .cfg_ifg(axis_if.cfg_ifg),
 .cfg_tx_enable(axis_if.cfg_tx_enable),
 .cfg_rx_enable(axis_if.cfg_rx_enable),
 .cfg_mcf_rx_eth_dst_mcast(axis_if.cfg_mcf_rx_eth_dst_mcast),
 .cfg_mcf_rx_check_eth_dst_mcast(axis_if.cfg_mcf_rx_check_eth_dst_mcast),
 .cfg_mcf_rx_eth_dst_ucast(axis_if.cfg_mcf_rx_eth_dst_ucast),
 .cfg_mcf_rx_check_eth_dst_ucast(axis_if.cfg_mcf_rx_check_eth_dst_ucast),
 .cfg_mcf_rx_eth_src(axis_if.cfg_mcf_rx_eth_src),
 .cfg_mcf_rx_check_eth_src(axis_if.cfg_mcf_rx_check_eth_src),
 .cfg_mcf_rx_eth_type(axis_if.cfg_mcf_rx_eth_type),
 .cfg_mcf_rx_opcode_lfc(axis_if.cfg_mcf_rx_opcode_lfc),
 .cfg_mcf_rx_check_opcode_lfc(axis_if.cfg_mcf_rx_check_opcode_lfc),
 .cfg_mcf_rx_opcode_pfc(axis_if.cfg_mcf_rx_opcode_pfc),
 .cfg_mcf_rx_check_opcode_pfc(axis_if.cfg_mcf_rx_check_opcode_pfc),
 .cfg_mcf_rx_forward(axis_if.cfg_mcf_rx_forward),
 .cfg_mcf_rx_enable(axis_if.cfg_mcf_rx_enable),
 .cfg_tx_lfc_eth_dst(axis_if.cfg_tx_lfc_eth_dst),
 .cfg_tx_lfc_eth_src(axis_if.cfg_tx_lfc_eth_src),
 .cfg_tx_lfc_eth_type(axis_if.cfg_tx_lfc_eth_type),
 .cfg_tx_lfc_opcode(axis_if.cfg_tx_lfc_opcode),
 .cfg_tx_lfc_en(axis_if.cfg_tx_lfc_en),
 .cfg_tx_lfc_quanta(axis_if.cfg_tx_lfc_en),
 .cfg_tx_lfc_refresh(axis_if.cfg_tx_lfc_refresh),
 .cfg_tx_pfc_eth_dst(axis_if.cfg_tx_pfc_eth_dst),
 .cfg_tx_pfc_eth_src(axis_if.cfg_tx_pfc_eth_dst),
 .cfg_tx_pfc_eth_type(axis_if.cfg_tx_pfc_eth_type),
 .cfg_tx_pfc_opcode(axis_if.cfg_tx_pfc_opcode),
 .cfg_tx_pfc_en(axis_if.cfg_tx_pfc_en),
 .cfg_tx_pfc_quanta(axis_if.cfg_tx_pfc_quanta),
 .cfg_tx_pfc_refresh(axis_if.cfg_tx_pfc_refresh),
 .cfg_rx_lfc_opcode(axis_if.cfg_rx_lfc_opcode),
 .cfg_rx_lfc_en(axis_if.cfg_rx_lfc_en),
 .cfg_rx_pfc_opcode(axis_if.cfg_rx_pfc_opcode),
 .cfg_rx_pfc_en(axis_if.cfg_rx_pfc_en)
 
               
);


/*
  assign  tb_rx_clk = aclk;
  assign  tb_rx_rst = aresetn;
  assign  tb_tx_clk = aclk;
  assign  tb_tx_rst = aresetn;  
*/

//initial begin
//tx_clk <= 0;
//rx_clk <= 0;
//end
//always #10 tx_clk <= ~tx_clk;
//always #10 rx_clk <= ~rx_clk;

/*
initial begin
  aresetn = 1;
  aclk=0;
  #50;
  aresetn = 0;
end

always
 #5 aclk = ~aclk;
*/

initial begin
  tb_tx_clk=0;
  tb_rx_clk=0;
end

always #10 tb_tx_clk  <= ~tb_tx_clk;
always #10 tb_rx_clk <= ~tb_rx_clk;

initial begin
  uvm_config_db#(virtual taxi_axis_if)::set(null, "*", "axis_if", axis_if);
  // $display("Set virtual interface: %p", axi_eth_tx_if);
  run_test("eth_mac_10g_test");
end
 
 
initial begin
$dumpfile("dump.vcd");
$dumpvars;
#5000 $finish;
end
 
endmodule
