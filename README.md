# UVM Hello World 

This is a test bench based on source code from EDA Playground annotated by yours truly, Martin, to facilitate learning SystemVerilog language and universal verification methodology (UVM) conceptual constructs essential to building your first simulation-based verification environment.

## What will you learn?

As in many programming languages, a "Hello World" is used as an introduction. In this introduction to UVM and simulation-based verification, a simple test bench (TB) environment is built to show what such an environment looks like, its topology, and how it creates, randomizes, propagates stimuli to the design under verification / test (DUV/DUT).

Since this is supposedly the first TB you will encounter, I carefully selected the concepts to annotate the source code with to enable the reader to understand what such UVM functionality actually means underneath. In so doing, the reader will catch the fundamental concepts that he / she will encounter in more advanced TBs later on.

Happy reading, simulating and learning, Cheers!

### Key Takeaways

__*test bench-to-DUT connection*__, __*stimuli propagation*__

## Test Bench Topology

![diagram_001 1-test_bench_topology](https://user-images.githubusercontent.com/50364461/212237340-df0fe5b7-4eef-4c66-a335-7752a833e2cc.png)

## How are all these mapped in the source code?

### File Structure:

![diagram_001 2-file_structure_mapping](https://user-images.githubusercontent.com/50364461/212237398-c1b9cbde-1ae5-4250-b497-83f437d71637.png)

\+ source
\
\| - design.sv
\
\| - testbench.sv
\
\| - my_testbench_pkg.svh
\
\| - my_driver.svh
\
\. - my_sequence.svh

### File Contents:
1. design.sv - DUV/DUT module and interface signals
2. testbench.sv - TB top module
3. my_testbench_pkg.svh - user-defined package containing the test case, environment, and agent components of the test bench
4. my_driver.svh - user-defined driver component
5. my_sequence.svh - user-defined sequence item and sequence objects

## Simulate & play with the code
EDA Playground Example - UVM Hello World
https://www.edaplayground.com/x/296

## Additional references
Shimizu, K. (2012, November 10). UVM Tutorial for Candy Lovers – 11. Sequence Item Port – ClueLogic. ClueLogic. https://cluelogic.com/2012/11/uvm-tutorial-for-candy-lovers-sequence-item-port/

UVM Sequence item. (n.d.). Verification Guide. Retrieved January 11, 2023, from https://verificationguide.com/uvm/uvm-sequence-item/
