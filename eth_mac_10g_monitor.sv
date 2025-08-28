class eth_mac_10g_monitor extends uvm_monitor;
   `uvm_component_utils(eth_mac_10g_monitor)
   
   virtual taxi_axis_if axis_if;
  
  uvm_analysis_port #(eth_mac_10g_seq_item) ap;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
      ap = new("ap", this);
   endfunction
  
  
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     if (!uvm_config_db#(virtual  taxi_axis_if)::get(this, "*", "axis_if", axis_if)) 
  begin
         `uvm_fatal("NO_VIF", "Virtual interface not set")
      end
   endfunction 
  
  
  
   virtual task run_phase(uvm_phase phase);
      forever begin
         eth_mac_10g_seq_item item;
        item = eth_mac_10g_seq_item::type_id::create("item");
        @(posedge axis_if.tx_clk);
        item.xgmii_rxd <=  axis_if.xgmii_rxd;
        item.xgmii_txd <=  axis_if.xgmii_txd;
        item.xgmii_rxc <=  axis_if.xgmii_rxc;
        item.xgmii_txc <=  axis_if.xgmii_txc;
        ap.write(item);
         end
   endtask
endclass
