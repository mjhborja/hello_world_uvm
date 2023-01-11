/* class: my_transaction
   uvm_sequence_item is an object used to encapsulate stimulus information
   controlled from the sequence in its packed transaction level (TLM) form and 
   propagated into the driver for translation into cycle-accurate (CA) signal 
   form: SEQ(TLM)<->DRIVER(CA). The user-defined sequence item embodies a 
   transaction including its fields used to generate signals to or capture  
   responses from the DUT.
 */
class my_transaction extends uvm_sequence_item;
  // registers "my_transaction" object into the uvm factory
  `uvm_object_utils(my_transaction)

  /* Using the discussion from (UVM Sequence Item, n.d.), control, payload,
     and configuration information originating from the TB are all randomized.
     This is why "rand" is appended to the field declarations.
   */
  rand bit cmd;
  rand int addr;
  rand int data;

  /* "constraint" is used to limit the range of legal values from which the
     randomized field gets generated from.
   */
  constraint c_addr { addr >= 0; addr < 256; }
  constraint c_data { data >= 0; data < 256; }

  // object constructor
  function new (string name = "");
    super.new(name);
  endfunction

endclass: my_transaction

class my_sequence extends uvm_sequence#(my_transaction);

  `uvm_object_utils(my_sequence)

  function new (string name = "");
    super.new(name);
  endfunction

  task body;
    repeat(8) begin
      req = my_transaction::type_id::create("req");
      start_item(req);

      if (!req.randomize()) begin
        `uvm_error("MY_SEQUENCE", "Randomize failed.");
      end

      // If using ModelSim, which does not support randomize(),
      // we must randomize item using traditional methods, like
      // req.cmd = $urandom;
      // req.addr = $urandom_range(0, 255);
      // req.data = $urandom_range(0, 255);

      finish_item(req);
    end
  endtask: body

endclass: my_sequence
