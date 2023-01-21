# UVM Hello World 

This is a test bench based on source code from EDA Playground annotated by yours truly, Martin, to facilitate learning SystemVerilog language and universal verification methodology (UVM) conceptual constructs essential to building your first simulation-based verification environment.

### Key Takeaways

__*test bench-to-DUT connection*__, __*stimuli propagation*__
## What will you learn here?

As in many programming languages, a "Hello World" is used as an introduction. In this introduction to UVM and simulation-based verification, a simple test bench (TB) environment is built to show what such an environment looks like, its topology, and how it creates, randomizes, propagates stimuli to the design under verification / test (DUV/DUT).

Since this is supposedly the first TB you will encounter, I carefully selected the concepts to annotate the source code with to enable the reader to understand what such UVM functionality actually means underneath. In so doing, the reader will catch the fundamental concepts that he / she will encounter in more advanced TBs later on.

Happy reading, simulating and learning, Cheers!

## Test bench topology
![diagram_001 1-test_bench_topology](https://user-images.githubusercontent.com/50364461/213082432-c0470637-bc0e-4b97-835a-5fd850b56226.png)

## Sequence diagram
The sequence diagram that describes what the test bench does is divided into 5 smaller diagrams. 

### Connection between top and the UVM test bench
First, the connection between the DUV/DUT and the UVM test bench is established at the top module.
![diagram_001 4-hello_world_uvm_sequence_diagram_top_to_test](https://user-images.githubusercontent.com/50364461/213087701-305a1210-ebc6-42a3-ad0d-905b68e3adbe.png)

### UVM Build phase
Second, the UVM test bench components are built synchronous with the UVM build_phase().
![diagram_001 5-hello_world_uvm_sequence_diagram_build_phase](https://user-images.githubusercontent.com/50364461/213088585-4dd0a9bc-258e-4f9e-a58e-2889dfdd510e.png)

### UVM Connect phase
Third, the sequencer is connected with the driver during the UVM connect_phase().
![diagram_001 6-hello_world_uvm_sequence_diagram_connect_phase](https://user-images.githubusercontent.com/50364461/213088705-c5ba8f93-fed7-4ab9-a6d0-c3607d501def.png)

### UVM Run phase excluding sequence body and driver signal propagation
And then for the fourth diagram, the uvm_objection mechanism is initiated during the run_phase().
![diagram_001 7-hello_world_uvm_sequence_diagram_run_phase_excluding_my_sequence_details](https://user-images.githubusercontent.com/50364461/213088729-73a355b3-bf18-48d2-a442-61d09bf75239.png)

### Sequence body and driver signal propagation
And finally, details of the sequence body are shown together with the handshake to drive interface signals connected to the driver via the UVM resources database.
![diagram_001 8-hello_world_uvm_sequence_diagram_run_phase_my_sequence_details](https://user-images.githubusercontent.com/50364461/213089070-f0c3d707-980a-4b96-9dc4-c706a25c8d33.png)

## How are all these mapped in the source code?

### File Structure:
![diagram_001 2-file_structure_mapping](https://user-images.githubusercontent.com/50364461/213090542-e9dac7f5-afd2-47df-8282-888e64409b9f.png)

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
EDA Playground Example - UVM Hello World by Victor Lyuboslavsky
https://www.edaplayground.com/x/296

## Additional references
[1] "IEEE Standard for Universal Verification Methodology Language Reference Manual," in IEEE Std 1800.2-2020 (Revision of IEEE Std 1800.2-2017) , vol., no., pp.1-458, 14 Sept. 2020, doi: 10.1109/IEEESTD.2020.9195920.
\
[2] K. Shimizu, “UVM Tutorial for Candy Lovers – 11. Sequence Item Port – ClueLogic,” ClueLogic, Nov. 10, 2012. https://cluelogic.com/2012/11/uvm-tutorial-for-candy-lovers-sequence-item-port/ (accessed Jan. 11, 2023).
\
[3] “UVM Sequence item,” Verification Guide. https://verificationguide.com/uvm/uvm-sequence-item/ (accessed Jan. 11, 2023).

## Note to reader
The review content including comments to the original source code, analysis, diagrams and overall presentation of the topic is Martin's original contribution. The base line source code for this post is not Martin's work.
