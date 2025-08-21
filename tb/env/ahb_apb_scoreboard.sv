class ahb_apb_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(ahb_apb_scoreboard)

	uvm_tlm_analysis_fifo #(ahb_trans) ahb_fifo;
	uvm_tlm_analysis_fifo #(apb_trans) apb_fifo;

	ahb_trans ahb_tran;
	apb_trans apb_tran;

//	ahb_trans ahb_trans;
//	apb_trans apb_trans;

	ahb_apb_env_config env_cfg;

	ahb_trans q[$];

	// Standard UVM Methods:
	extern function new(string name = "ahb_apb_scoreboard",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern function void check_data(apb_trans trans);
	extern function void compare_data(int Hdata, Pdata, Haddr, Paddr);


endclass

//-----------------  constructor new method  -------------------//
function ahb_apb_scoreboard::new(string name = "ahb_apb_scoreboard",uvm_component parent);
	super.new(name,parent);
endfunction

//-----------------  build phase method  -------------------//
function void ahb_apb_scoreboard::build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(ahb_apb_env_config)::get(this, "", "ahb_apb_env_config", env_cfg))
		`uvm_fatal("scoreboard","cannot get env_cfg, have you set() it?")

	ahb_fifo = new("ahb_fifo",this);
	apb_fifo = new("apb_fifo",this);


endfunction

//-----------------  run_phase() method  -------------------//
task ahb_apb_scoreboard::run_phase(uvm_phase phase);
	fork
		forever begin
			ahb_fifo.get(ahb_tran);
//			ahb_tran.print();
			q.push_back(ahb_tran);
			$display("size of the queue = %d",q.size);
//			ahb_cov_data = ahb_tran;
//			ahb_cg.sample();
		end

		forever begin
			apb_fifo.get(apb_tran);
//			apb_tran.display("apb Data from SB");
			check_data(apb_tran);
//			apb_cov_data = apb_tran;
//			apb_cg.sample();
		end
	join
endtask

//-----------------  check_data() method  -------------------//
function void ahb_apb_scoreboard::check_data(apb_trans trans);

	ahb_tran = q.pop_front();

	if(ahb_tran.Hwrite) begin
		case(ahb_tran.Hsize)

		2'b00:
		begin
			if(ahb_tran.Haddr[1:0] == 2'b00)
				compare_data(ahb_tran.Hwdata[7:0], apb_tran.Pwdata[7:0], ahb_tran.Haddr, apb_tran.Paddr);

			if(ahb_tran.Haddr[1:0] == 2'b01)
				compare_data(ahb_tran.Hwdata[15:8], apb_tran.Pwdata[7:0], ahb_tran.Haddr, apb_tran.Paddr);

			if(ahb_tran.Haddr[1:0] == 2'b10)
				compare_data(ahb_tran.Hwdata[23:16], apb_tran.Pwdata[7:0], ahb_tran.Haddr, apb_tran.Paddr);

			if(ahb_tran.Haddr[1:0] == 2'b11)
				compare_data(ahb_tran.Hwdata[31:24], apb_tran.Pwdata[7:0], ahb_tran.Haddr, apb_tran.Paddr);

		end

		2'b01:
		begin
			if(ahb_tran.Haddr[1:0] == 2'b00)
				compare_data(ahb_tran.Hwdata[15:0], apb_tran.Pwdata[15:0], ahb_tran.Haddr, apb_tran.Paddr);

			if(ahb_tran.Haddr[1:0] == 2'b10)
				compare_data(ahb_tran.Hwdata[31:16], apb_tran.Pwdata[15:0], ahb_tran.Haddr, apb_tran.Paddr);

		end

		2'b10:
			begin
				compare_data(ahb_tran.Hwdata, apb_tran.Pwdata, ahb_tran.Haddr, apb_tran.Paddr);

			end
		endcase
	end

	else begin
		case(ahb_tran.Hsize)

		2'b00:
		begin
			if(ahb_tran.Haddr[1:0] == 2'b00)
				compare_data(ahb_tran.Hrdata[7:0], apb_tran.Prdata[7:0], ahb_tran.Haddr, apb_tran.Paddr);

			if(ahb_tran.Haddr[1:0] == 2'b01)
				compare_data(ahb_tran.Hrdata[7:0], apb_tran.Prdata[15:8], ahb_tran.Haddr, apb_tran.Paddr);

			if(ahb_tran.Haddr[1:0] == 2'b10)
				compare_data(ahb_tran.Hrdata[7:0], apb_tran.Prdata[23:16], ahb_tran.Haddr, apb_tran.Paddr);

			if(ahb_tran.Haddr[1:0] == 2'b11)
				compare_data(ahb_tran.Hrdata[7:0], apb_tran.Prdata[31:24], ahb_tran.Haddr, apb_tran.Paddr);

		end

		2'b01:
		begin
			if(ahb_tran.Haddr[1:0] == 2'b00)
				compare_data(ahb_tran.Hrdata[15:0], apb_tran.Prdata[15:0], ahb_tran.Haddr, apb_tran.Paddr);

			if(ahb_tran.Haddr[1:0] == 2'b10)
				compare_data(ahb_tran.Hrdata[15:0], apb_tran.Prdata[31:16], ahb_tran.Haddr, apb_tran.Paddr);

		end

		2'b10:
			begin
				compare_data(ahb_tran.Hrdata, apb_tran.Prdata, ahb_tran.Haddr, apb_tran.Paddr);

			end
		endcase
	end
		

endfunction

//-----------------  compare_data() method  -------------------//
function void ahb_apb_scoreboard::compare_data(int Hdata, Pdata, Haddr, Paddr);

	if(Haddr == Paddr) begin
		$display("Address comparision successful");
		$display("Haddr = %h, Paddr =%h",Haddr, Paddr);
	end
	else begin
		$display("Address comparision failed");
		$display("Haddr = %h, Paddr =%h",Haddr, Paddr);
//		$finish;
	end

	if(Hdata == Pdata) begin
		$display("Data comparision successful");
		$display("HWDATA/HRDATA = %h, PWDATA/PRDATA =%h",Hdata, Pdata);
	end
	else begin
		$display("Data comparision failed");
		$display("HWDATA/HRDATA = %h, PWDATA/PRDATA =%h",Hdata, Pdata);
//		$finish;
	end

endfunction
