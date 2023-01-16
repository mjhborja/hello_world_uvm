/*******************************************
This is a basic UVM "Hello World" testbench.

Explanation of this testbench on YouTube:
https://www.youtube.com/watch?v=Qn6SvG-Kya0
*******************************************/

// includes definition of uvm macros and user-defined package in this compilation unit
`include "uvm_macros.svh"
`include "my_testbench_pkg.svh"

// module: top
// The top module that contains the DUT and interface.
// This module starts the test.
module top;
  /* imports uvm and user-defined package to enable type compatibility for the
     respective package libraries
   */
  import uvm_pkg::*;
  import my_testbench_pkg::*;
  
  /* instances of design and interface - elements that connect the design (DUT) side
     with the test bench (TB) side of things
   */
  // Instantiate the interface
  dut_if dut_if1();
  
  // Instantiate the DUT and connect it to the interface
  dut dut1(.dif(dut_if1));
  
  /* non-uvm signal generation at the test bench top layer driven in a SystemVerilog
     "initial" block
   */
  // Clock generator
  initial begin
    dut_if1.clock = 0;
    forever #5 dut_if1.clock = ~dut_if1.clock;
  end
  
  /* Connection with the uvm TB side: TB(VIF)<->DUT(IF)
     - invoking the uvm resources database using uvm_config_db interface method "set()"
     to make the interface instance object available to the uvm TB side
     - invoking the global "run_test()" method triggers the creation of the test specified 
     from the command line using "+UVM_TESTNAME=test_name" by the factory and starts
     phasing
   */
  initial begin
    /* 1. invoke "set()" method of the uvm_config_db interface to the UVM 
       resource database
       Place the interface into the UVM configuration database
     */
    uvm_config_db#(virtual dut_if)::set(null, "*", "dut_vif", dut_if1);
    /* 2. invoke global "run_test()" method to phase all components in the test
       bench hierarchy
       3. occurs internal to the UVM base class library (BCL)
       Start the test
     */
    run_test("my_test");
  end
  
  /* $dumpfile and $dumpvars are SystemVerilog functions to specify:
     - the waveform or value change dump (*.vcd) file into which the values of 
     - the variables from the design hierarchy, n-levels below the specified base level
     respectively
   */
  // Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, top);
  end
  
endmodule
