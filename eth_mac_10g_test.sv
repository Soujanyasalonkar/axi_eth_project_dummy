//import axi_eth_pkg::*;


class eth_mac_10g_test extends uvm_test;
  `uvm_component_utils(eth_mac_10g_test)
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  eth_mac_10g_env env;
  eth_mac_10g_seq seq1;

  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = eth_mac_10g_env::type_id::create("env",this);
    seq1 = eth_mac_10g_seq::type_id::create("seq1");
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("TEST",sprint(),UVM_LOW)
  endfunction
  
  task run_phase(uvm_phase phase);
    
    phase.raise_objection(this);
    seq1.start(env.agent.eth_mac_10g_sequencer);
    #20
    phase.drop_objection(this);
  endtask
endclass
  
  
    
