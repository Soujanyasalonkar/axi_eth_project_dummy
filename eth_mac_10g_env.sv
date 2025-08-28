class eth_mac_10g_env extends uvm_env;
  `uvm_component_utils(eth_mac_10g_env)
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  eth_mac_10g_agent agent;
//  apb_scb scb;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = eth_mac_10g_agent::type_id::create("agent",this);
   // scb = apb_scb::type_id::create("scb",this);
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //agent.mon.mon_ap.connect(scb.scb_ip);
  endfunction
  
endclass
  
