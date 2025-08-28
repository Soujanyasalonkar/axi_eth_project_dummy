class eth_mac_10g_seq_item extends uvm_sequence_item;
  
  parameter DATA_WIDTH = 64;
  parameter KEEP_WIDTH = (DATA_WIDTH/8);
  parameter CTRL_WIDTH = (DATA_WIDTH/8);
  parameter TX_USER_WIDTH = 1;
 parameter RX_USER_WIDTH = 2;
  
  rand bit[DATA_WIDTH-1:0] tx_axis_tdata[$];
  rand bit[KEEP_WIDTH-1:0] tx_axis_tkeep;
  rand bit tx_axis_tvalid;
  bit tx_axis_tready;
  rand bit tx_axis_tlast;
  rand bit[TX_USER_WIDTH-1:0] tx_axis_tuser;
  bit[DATA_WIDTH-1:0]   rx_axis_tdata;
  bit[KEEP_WIDTH-1:0]  rx_axis_tkeep;
  bit  rx_axis_tvalid;
  bit rx_axis_tlast;
  bit[RX_USER_WIDTH-1:0] rx_axis_tuser;
  

    /*
     * XGMII interface
     */
  rand bit[DATA_WIDTH-1:0]   xgmii_rxd;
  rand bit[CTRL_WIDTH-1:0]   xgmii_rxc;
  bit[DATA_WIDTH-1:0]        xgmii_txd;
  bit[CTRL_WIDTH-1:0]        xgmii_txc;

  
  
  constraint c1 {tx_axis_tdata.size == 15;}
   
  `uvm_object_utils(eth_mac_10g_seq_item)

  function new(string name = "eth_mac_10g_seq_item");
      super.new(name);
   endfunction

endclass
