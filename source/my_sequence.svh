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

  /* Using the discussion from [3], control, payload,
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

/* class: my_sequence
   uvm_sequence is an object used to create transaction related events or
   manage other sequences.
   In this specific user-defined sequence example, a sequence item is:
   1. created;
   2. introduced to the connected driver for propagation;
   3. randomized;
   4. sent to the driver; and 
   5. lastly, end indicating the corresponding transaction completion response
   from the driver.
   This is iterated for 8 random transactions in the body().
 */
class my_sequence extends uvm_sequence#(my_transaction);
  // registers "my_sequence" object into the uvm factory
  `uvm_object_utils(my_sequence)
  
  // object constructor
  function new (string name = "");
    super.new(name);
  endfunction

  /* "body()" is a task that is invoked by either a sequencer associated with
     the sequence's start method or a sequence with a null sequencer.
   */
  task body;
    repeat(8) begin
      // A sequence item is created - 1.
      req = my_transaction::type_id::create("req");

      /* The start_item() method call indicates that this sequence is 
         associated with a sequencer. This is a blocking method that requests 
         the driver on the other end to propagate the sequence item - 2.
       */
      start_item(req);

      /* Once the driver grants the request, the item can now be randomized
         in order to retain the most recent values based on the item 
         constraints prior to sending to the driver via the sequencer - 3.
       */
      if (!req.randomize()) begin
        `uvm_error("MY_SEQUENCE", "Randomize failed.");
      end

      // If using ModelSim, which does not support randomize(),
      // we must randomize item using traditional methods, like
      // req.cmd = $urandom;
      // req.addr = $urandom_range(0, 255);
      // req.data = $urandom_range(0, 255);

      /* The finish_item() method call is also a blocking method. It sends the
         sequence item to the driver via the sequencer - 4. And then it ends 
         upon receipt of completion - 5.
       */
      finish_item(req);
    end
  endtask: body

endclass: my_sequence
