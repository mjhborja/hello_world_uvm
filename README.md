# hello_world_uvm
UVM Hello World 

This is a test bench based on source code from EDA Playground annotated by Martin to facilitate learning SystemVerilog language and universal verification methodology (UVM) conceptual constructs essential to building your first simulation-based verification environment.

File Structure:
+ source
| - design.sv
| - testbench.sv
| - my_testbench_pkg.svh
| - my_driver.svh
. - my_sequence.svh

File Contents:
1. design.sv - design under test (DUT) module and interface signals
2. testbench.sv - test bench (TB) top module
3. my_testbench_pkg.svh - user-defined package containing the test case, environment, and agent components of the test bench
4. my_driver.svh - user-defined driver component
5. my_sequence.svh - user-defined sequence item and sequence objects

Original / reference source code courtesy of EDA Playground
https://www.edaplayground.com/x/296