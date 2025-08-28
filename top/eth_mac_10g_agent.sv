class eth_mac_10g_agent extends uvm_agent;
  `uvm_component_utils(eth_mac_10g_agent)
   
   eth_mac_10g_driver eth_mac_10g_driver_h;
   eth_mac_10g_monitor eth_mac_10g_monitor_h;
   uvm_sequencer #(eth_mac_10g_seq_item) eth_mac_10g_sequencer;
   
  // virtual axi_ethernet_tx_interface axi_eth_tx_vif;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      eth_mac_10g_monitor_h = eth_mac_10g_monitor::type_id::create("eth_mac_10g_monitor_h", this);
      
      if (get_is_active() == UVM_ACTIVE) begin
         eth_mac_10g_driver_h = eth_mac_10g_driver::type_id::create("eth_mac_10g_driver_h", this);
         eth_mac_10g_sequencer = uvm_sequencer#(eth_mac_10g_seq_item)::type_id::create("eth_mac_10g_sequencer", this);
      end
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      //axi_eth_tx_monitor_h.axi_eth_tx_if = axi_eth_tx_vif;
      if (get_is_active() == UVM_ACTIVE) begin
        // axi_eth_tx_driver_h.axi_eth_tx_if = axi_eth_tx_vif;
         eth_mac_10g_driver_h.seq_item_port.connect(eth_mac_10g_sequencer.seq_item_export);
      end
   endfunction
endclass
