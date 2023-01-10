// package: my_testbench_pkg
// example user-defined package extending uvm_pkg constructs
package my_testbench_pkg;
  /* imports SystemVerilog enabling type compatibility for the entire 
     library defined within the uvm package
   */
  import uvm_pkg::*;
  
  // includes definitions of user-defined constructs extending:
  // The UVM sequence, transaction item, and driver are in these files:
  `include "my_sequence.svh"
  `include "my_driver.svh"
  
  // class: my_agent
  // This is a user-defined active agent.
  // The agent contains sequencer, driver, and monitor (not included)
  class my_agent extends uvm_agent;
    `uvm_component_utils(my_agent)
    
    // instances of driver and sequencer
    my_driver driver;
    uvm_sequencer#(my_transaction) sequencer;
    
    /* SystemVerilog uses OOP concepts. This is its version of a constructor 
       for the class object.
     */
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    /* BUILD PHASES include build_phase, connect_phase, and
       end_of_elaboration_phase, which all occur in that sequence at time 0 
       prior to RUN TIME PHASES.
    */

    /* build_phase is one of the common phases every uvm object synchronizes
       with during execution. It is used for creation and configuration of
       components of the test bench.
     */
    function void build_phase(uvm_phase phase);
      /* create method allows factory substitution of the driver type when
         without modifying the latter using overrides configured during
         instantiation.
       */ 
      driver = my_driver ::type_id::create("driver", this);
      sequencer =
        uvm_sequencer#(my_transaction)::type_id::create("sequencer", this);
    endfunction    
    
    /* connect_phase occurs right after the build_phase. And it is used to
       connect components according to the topology of the test bench 
       environment.
     */
    // In UVM connect phase, we connect the sequencer to the driver.
    function void connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
    
    task run_phase(uvm_phase phase);
      // We raise objection to keep the test from completing
      phase.raise_objection(this);
      begin
        my_sequence seq;
        seq = my_sequence::type_id::create("seq");
        seq.start(sequencer);
      end
      // We drop objection to allow the test to complete
      phase.drop_objection(this);
    endtask

  endclass
  
  class my_env extends uvm_env;
    `uvm_component_utils(my_env)
    
    my_agent agent;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      agent = my_agent::type_id::create("agent", this);
    endfunction

  endclass
  
  class my_test extends uvm_test;
    `uvm_component_utils(my_test)
    
    my_env env;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      env = my_env::type_id::create("env", this);
    endfunction
    
    task run_phase(uvm_phase phase);
      // We raise objection to keep the test from completing
      phase.raise_objection(this);
      #10;
      `uvm_warning("", "Hello World!")
      // We drop objection to allow the test to complete
      phase.drop_objection(this);
    endtask

  endclass
  
endpackage