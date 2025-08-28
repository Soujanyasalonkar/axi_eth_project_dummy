class eth_mac_10g_sequencer extends uvm_sequencer#(eth_mac_10g_seq_item);
  `uvm_component_utils(eth_mac_10g_sequencer)
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass
