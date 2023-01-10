// interface: dut_if
// This is the SystemVerilog interface that we will use to connect
// our design to our UVM testbench.
interface dut_if;
  logic clock, reset;
  logic cmd;
  logic [7:0] addr;
  logic [7:0] data;
endinterface

// includes definition of uvm macros in this compilation unit
`include "uvm_macros.svh"

// module: dut
// instantiation style: TB(VIF)<->DUT(IF)
// This is our design module.
// 
// It is an empty design that simply prints a message whenever
// the clock toggles. Refer to the [print] block.
module dut(dut_if dif);
  /* imports SystemVerilog enabling type compatibility for the entire 
     library defined within the uvm package
   */
  import uvm_pkg::*;
  // [print] is implemented using a SystemVerilog "always @(<signal sensitivity list>)" block.
  always @(posedge dif.clock)
    if (dif.reset != 1) begin
      // `uvm_info is a uvm macro accessible through the inclusion of uvm_macros.svh
      `uvm_info("DUT",
                $sformatf("Received cmd=%b, addr=0x%2h, data=0x%2h",
                          dif.cmd, dif.addr, dif.data), UVM_MEDIUM)
    end
endmodule
