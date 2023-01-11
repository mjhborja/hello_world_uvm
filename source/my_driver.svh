/* class: my_driver
   uvm_driver is a parameterized component that 
   - enacts requests originating from a seq_item_port (further its parent
   seq_item_pull_port) that receives sequence items from a connected 
   seq_item_export (further its parent seq_item_pull_imp) 
   - the parameters are the sequence item types of the request and response
   with the latter having the former as its default type 
 */
class my_driver extends uvm_driver #(my_transaction);
  // registers "my_driver" component into the uvm factory
  `uvm_component_utils(my_driver)

  /* instance of the virtual interface that physically connects with the DUT's
     interface
   */
  virtual dut_if dut_vif;

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  /* component build_phase retrieves the interface resource set at the TB top
     and stores it in the specified variable, in this case the virtual 
     interface dut_vif. This completes the connection between the test bench
     and DUT: TB(VIF)<->DUT(IF) style
   */
  function void build_phase(uvm_phase phase);
    // Get interface reference from config database
    if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_vif", dut_vif)) begin
      `uvm_error("", "uvm_config_db::get failed")
    end
  endfunction 

  /* component run_phase executes time-consuming activities. In this example,
     there is no stimulus partitioning. Hence, only one phase is utilized. 
     For items originating from the sequence, the SystemVerilog "forever" 
     construct is used to encapsulate the sequencer handshake between
     "get_next_item()" and "item_done()" (Shimizu, 2012).
   */
  task run_phase(uvm_phase phase);
    // First toggle reset
    dut_vif.reset = 1;
    @(posedge dut_vif.clock);
    #1;
    dut_vif.reset = 0;
    
    // Now drive normal traffic
    forever begin
      seq_item_port.get_next_item(req);

      // Wiggle pins of DUT
      dut_vif.cmd  = req.cmd;
      dut_vif.addr = req.addr;
      dut_vif.data = req.data;
      @(posedge dut_vif.clock);

      seq_item_port.item_done();
    end
  endtask

endclass: my_driver
