// package: my_testbench_pkg
// example user-defined package extending uvm_pkg constructs
package my_testbench_pkg;
  /* imports a package namespace that SystemVerilog uses to enable type 
     compatibility for the entire library defined within the uvm_pkg package
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
    /* `uvm_component_utils is a macro that registers the component, in this
       case "my_agent," which is a non-parameterized component into the uvm 
       factory.
     */
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
      /* create method allows factory substitution of the driver type 
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
    /* RUN TIME PHASES embody the testing processes within the simulation.
       "run_phase" occurs right after the start_of_simulation_phase, two phases
       after build_phase. And it is a time consuming phase used to execute  
       all simulation activities and transactions. Stimuli partitioning is
       achievable through the sub phases, which is worth another topic.
     */
    task run_phase(uvm_phase phase);
      /* "raise_objection()" is a method that indicates whether it is safe
         to end a phase. It is necessary to raise the objection manually in
         the case of explicitly started sequences as is shown in this example.
       */
      // We raise objection to keep the test from completing
      phase.raise_objection(this);
      begin
        my_sequence seq;
        seq = my_sequence::type_id::create("seq");
        /* Explicit start for a sequence invoked using the "start()" method
           from within the agent. 
         */
        seq.start(sequencer);
      end
      /* "drop_objection()" is manually invoked to indicate phase activity 
        completion as a consequence of the explicit sequence start in this 
        example.
       */
      // We drop objection to allow the test to complete
      phase.drop_objection(this);
    endtask

  endclass
  
  /* class: my_env
     uvm_env is the container component for a complete environment at a
     specific test bench abstraction layer. Environment layering is a
     technique used for designs with larger scope, e.g. sub-system, SoC, 
     chip level. A user-defined environment is defined as follows.
   */
  class my_env extends uvm_env;
    // registers "my_env" component into the uvm factory
    `uvm_component_utils(my_env)
    
    my_agent agent;
    
    // component constructor
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    /* component build_phase creates its sub-components using the uvm
       factory
     */
    function void build_phase(uvm_phase phase);
      agent = my_agent::type_id::create("agent", this);
    endfunction

  endclass
  
  /* class: my_test
     uvm_test is extended by user-defined tests to inherit pre-defined
     features that:
     - connect the execution scheduling of the test with the phases,
     - the testbench (TB) top SystemVerilog module, and
     - the simulator command line argument +UVM_TESTNAME
   */
  class my_test extends uvm_test;
    // registers "my_test" component into the uvm factory
    `uvm_component_utils(my_test)
    
    my_env env;

    // component constructor
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
     /* component build_phase creates its sub-components using the uvm
       factory
     */
    function void build_phase(uvm_phase phase);
      env = my_env::type_id::create("env", this);
    endfunction
    
    /* component run_phase executes time-consuming activities / tasks
       unitl the objection count drops to 0 signaling the end of the 
       phase.
     */
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