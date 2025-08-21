class apb_sequence extends uvm_sequence #(apb_trans);

	`uvm_object_utils(apb_sequence)

	// Standard UVM Methods:
	extern function new(string name ="apb_sequence");
	extern task body();

endclass

//-----------------  constructor new() method  -------------------//
function apb_sequence::new(string name ="apb_sequence");
	super.new(name);
endfunction

//-----------------  task body method  -------------------//
task apb_sequence::body();

//	repeat(10) begin
		req = apb_trans::type_id::create("req");
		req.print();
		start_item(req);
		assert(req.randomize());
		finish_item(req);
//	end

endtask
