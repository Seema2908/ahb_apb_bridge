class ahb_sequence extends uvm_sequence #(ahb_trans);

	`uvm_object_utils(ahb_sequence)

	// Standard UVM Methods:
	extern function new(string name ="ahb_sequence");

endclass

//-----------------  constructor new() method  -------------------//
function ahb_sequence::new(string name ="ahb_sequence");
	super.new(name);
endfunction

//----------------- ahb_seqs --------------------------//
class ahb_seqs extends ahb_sequence;

	`uvm_object_utils(ahb_seqs)

	logic [31:0] haddr;
	logic hwrite;
	logic [2:0] hsize;
	logic [2:0] hburst;

	// Standard UVM Methods:
	extern function new(string name ="ahb_seqs");
	extern task body();

endclass

//----------------- ahb_seqs --------------------------//
function ahb_seqs::new(string name ="ahb_seqs");
	super.new(name);
endfunction

task ahb_seqs::body();

	req = ahb_trans::type_id::create("req");

	start_item(req);
	assert(req.randomize() with {Htrans == 2'b10;});
	finish_item(req);

	haddr = req.Haddr;
	hsize = req.Hsize;
	hburst = req.Hburst;
	hwrite = req.Hwrite;

	$display("haddr = %b, hsize = %b, hburst = %b, hwrite = %b" ,haddr, hsize, hburst, hwrite);

	// -------------- INCR4 --------------------------//
	if(hburst == 3'b011) begin
		for(int i=0; i<3; i++) begin
			start_item(req);

			if(hsize ==  0)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == haddr + 1'b1;});

			if(hsize ==  1)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == haddr + 2'b10;});

			if(hsize ==  2)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == haddr + 3'b100;});

			finish_item(req);

			haddr = req.Haddr;

		end
	end


	// -------------- INCR8 --------------------------//
	if(hburst == 3'b101) begin
		for(int i=0; i<7; i++) begin
			start_item(req);

			if(hsize ==  0)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == haddr + 1'b1;});

			if(hsize ==  1)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == haddr + 2'b10;});

			if(hsize ==  2)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == haddr + 3'b100;});

			finish_item(req);

			haddr = req.Haddr;

		end
	end


	// -------------- INCR16 --------------------------//
	if(hburst == 3'b111) begin
		for(int i=0; i<15; i++) begin
			start_item(req);

			if(hsize ==  0)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == haddr + 1'b1;});

			if(hsize ==  1)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == haddr + 2'b10;});

			if(hsize ==  2)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == haddr + 3'b100;});

			finish_item(req);

			haddr = req.Haddr;

		end
	end


	// -------------- INCR --------------------------//
	if(hburst == 3'b001) begin
		for(int i=0; i<req.length; i++) begin
			start_item(req);

			if(hsize ==  0)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == haddr + 1'b1;});

			if(hsize ==  1)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == haddr + 2'b10;});

			if(hsize ==  2)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == haddr + 3'b100;});

			finish_item(req);

			haddr = req.Haddr;

		end
	end


	// -------------- WRAP4 --------------------------//
	if(hburst == 3'b010) begin
		for(int i=0; i<3; i++) begin
			start_item(req);

			if(hsize ==  0)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == {haddr[31:2], haddr[1:0] + 1'b1}; });

			if(hsize ==  1)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == {haddr[31:3], haddr[2:1] + 1'b1, haddr[0]}; });

			if(hsize ==  2)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == {haddr[31:4], haddr[3:2] + 1'b1, haddr[1:0]}; });

			finish_item(req);

			haddr = req.Haddr;

		end
	end


	// -------------- WRAP8 --------------------------//
	if(hburst == 3'b100) begin
		for(int i=0; i<7; i++) begin
			start_item(req);

			if(hsize ==  0)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == {haddr[31:3], haddr[2:0] + 1'b1}; });

			if(hsize ==  1)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == {haddr[31:4], haddr[3:1] + 1'b1, haddr[0]}; });

			if(hsize ==  2)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == {haddr[31:5], haddr[4:2] + 1'b1, haddr[1:0]}; });

			finish_item(req);

			haddr = req.Haddr;

		end
	end


	// -------------- WRAP16 --------------------------//
	if(hburst == 3'b110) begin
		for(int i=0; i<15; i++) begin
			start_item(req);

			if(hsize ==  0)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == {haddr[31:4], haddr[3:0] + 1'b1}; });

			if(hsize ==  1)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == {haddr[31:5], haddr[4:1] + 1'b1, haddr[0]}; });

			if(hsize ==  2)
			assert (req.randomize() with {Hsize == hsize; Hburst == hburst; Hwrite == hwrite; Htrans == 2'b11; Haddr == {haddr[31:6], haddr[5:2] + 1'b1, haddr[1:0]}; });

			finish_item(req);

			haddr = req.Haddr;

		end
	end

endtask
