class ahb_trans extends uvm_sequence_item;

	`uvm_object_utils(ahb_trans)

//	extern function new(string name="ahb_trans");

	rand logic [31:0] Haddr;
	rand logic [2:0]  Hsize;
	rand logic [2:0]  Hburst;
	rand logic 	  	Hwrite;
	rand logic [7:0]  length;
	rand logic [31:0] Hwdata;
	logic      [31:0] Hrdata;
	rand logic [1:0]  Htrans;
	
	constraint valid_size {Hsize inside {[0:2]};}
	constraint valid_length {(2**Hsize) *length <=1024;}
//	constraint valid_Htrans {Htrans == 2'b10;}
	constraint valid_Haddr {Hsize == 1 -> Haddr%2 == 0;
			Hsize == 2 -> Haddr%4 == 0;
					}
	constraint valid_Haddr1 {Haddr inside {[32'h8000_0000:32'h8000_03ff],[32'h8400_0000:32'h8400_03ff],[32'h8800_0000:32'h8800_03ff],[32'h8c00_0000:32'h8c00_03ff]};}

endclass

/*
function ahb_trans::new(string name="ahb_trans");
        super.new(name);
endfunction
*/	

