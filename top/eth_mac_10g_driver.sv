class eth_mac_10g_driver extends uvm_driver #(eth_mac_10g_seq_item);
   `uvm_component_utils(eth_mac_10g_driver)
   
   virtual taxi_axis_if axis_if;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction
  
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     if (!uvm_config_db#(virtual  taxi_axis_if)::get(this, "*", "axis_if", axis_if)) 
         `uvm_fatal("NO_VIF", "Virtual interface not set")
  
     `uvm_info("DRV", $sformatf("Interface handle: %p", axis_if), UVM_LOW)
   endfunction 
       
   virtual task run_phase(uvm_phase phase);
      forever begin
         seq_item_port.get_next_item(req);
         drive_packet(req);
         seq_item_port.item_done();
      end
   endtask
   
   virtual task drive_packet(eth_mac_10g_seq_item item);
    axis_if.cfg_ifg<=0;
    axis_if.cfg_tx_enable<=0;
    axis_if.cfg_rx_enable<=0;
    axis_if.cfg_mcf_rx_eth_dst_mcast<=0;
    axis_if.cfg_mcf_rx_check_eth_dst_mcast<=0;
    axis_if.cfg_mcf_rx_eth_dst_ucast<=0;
    axis_if.cfg_mcf_rx_check_eth_dst_ucast<=0;
    axis_if.cfg_mcf_rx_eth_src<=0;
    axis_if.cfg_mcf_rx_check_eth_src<=0;
    axis_if.cfg_mcf_rx_eth_type<=0;
    axis_if.cfg_mcf_rx_opcode_lfc<=0;
    axis_if.cfg_mcf_rx_check_opcode_lfc<=0;
    axis_if.cfg_mcf_rx_opcode_pfc<=0;
    axis_if.cfg_mcf_rx_check_opcode_pfc<=0;
    axis_if.cfg_mcf_rx_forward<=0;
    axis_if.cfg_mcf_rx_enable<=0;
    axis_if.cfg_tx_lfc_eth_dst<=0;
    axis_if.cfg_tx_lfc_eth_src<=0;
    axis_if.cfg_tx_lfc_eth_type<=0;
    axis_if.cfg_tx_lfc_opcode<=0;
    axis_if.cfg_tx_lfc_en<=0;
    axis_if.cfg_tx_lfc_quanta<=0;
    axis_if.cfg_tx_lfc_refresh<=0;
    axis_if.cfg_tx_pfc_eth_dst<=0;
    axis_if.cfg_tx_pfc_eth_src<=0;
    axis_if.cfg_tx_pfc_eth_type<=0;
    axis_if.cfg_tx_pfc_opcode<=0;
    axis_if.cfg_tx_pfc_en<=0;
    axis_if.cfg_tx_pfc_quanta<=0;
    axis_if.cfg_tx_pfc_refresh<=0;
    axis_if.cfg_rx_lfc_opcode<=0;
    axis_if.cfg_rx_lfc_en<=0;
    axis_if.cfg_rx_pfc_opcode<=0;
    axis_if.cfg_rx_pfc_en<=0;

     @(posedge axis_if.tx_clk);
       axis_if.tvalid <= 1'b1;
     while (!axis_if.tready) @(posedge axis_if.tx_clk);
     foreach(item.tx_axis_tdata[i]) begin
       @(posedge axis_if.tx_clk)
       axis_if.tdata <= item.tx_axis_tdata[i];
       
       if(i==item.tx_axis_tdata.size()-1)
          item.tx_axis_tlast=1; 
     end
     axis_if.tkeep <= item.tx_axis_tlast;
     axis_if.tlast <= item.tx_axis_tlast;
     axis_if.tuser <= item.tx_axis_tuser;
   endtask
     endclass
       
  
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     

