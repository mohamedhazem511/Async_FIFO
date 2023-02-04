//port list of inputs and outputs ports
module fifo_mem # (parameter    WIDTH = 8,
                                ADDR  = 3
                               )
(
    input  wire                         wclk,wrst_n,
    input  wire                         wclken,wfull,
    input  wire   [WIDTH-1:0]           wdata,  
    input  wire   [ADDR-1:0]            waddr,raddr,
    output wire   [WIDTH-1:0]           rdata
);


localparam   DEPTH = 1<<ADDR;
/// assign memory
reg [WIDTH-1:0] mem [0:DEPTH-1];
 
assign rdata = mem[raddr];

//integer number
integer num;

  always @(posedge wclk or negedge wrst_n) 
	begin
    if (!wrst_n) 
		  begin
          for ( num = 0 ; num < DEPTH ; num = num + 1 )
          mem[num] <= 0;
		  end
	  else if (wclken && !wfull)
          begin
          mem [waddr] <= wdata; 
          end
    end

endmodule