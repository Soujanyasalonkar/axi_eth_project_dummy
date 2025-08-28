class eth_mac_10g_seq extends uvm_sequence #(eth_mac_10g_seq_item);
   `uvm_object_utils(eth_mac_10g_seq)


  function new(string name = "eth_mac_10g_seq");
      super.new(name);
   endfunction

   task body();
      eth_mac_10g_seq_item tx_item;
      
     repeat (5) begin
         tx_item = eth_mac_10g_seq_item::type_id::create("tx_item");
         
         start_item(tx_item);
         
          tx_item.randomize();
         
         finish_item(tx_item);
      end
   endtask
endclass
