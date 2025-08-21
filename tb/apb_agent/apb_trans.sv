class apb_trans extends uvm_sequence_item;

	`uvm_object_utils(apb_trans)

//	extern function new(string name="apb_trans");

	logic Penable;
	logic Pwrite;
	logic [31:0] Pwdata;
	rand logic [31:0] Prdata;
	logic [31:0] Paddr;
	logic [3:0] Pselx;

endclass

/*
function apb_trans::new(string name="apb_trans");
        super.new(name);
endfunction
*/


