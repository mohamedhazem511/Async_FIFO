/*
   Created by : Mohamed Hazem Mamdouh
   30-11-2022
   7:30 PM
 */

//***************  FIFO Module Top ***************//

module fifo_top  # ( parameter        WIDTH = 8,
                                      DEPTH = 8,
                                      ADDR  = 3
                       )

(
 input   wire                        wclk,rclk,
 input   wire                        wrst_n,rrst_n,
 input   wire                        winc,rinc,
 input   wire   [WIDTH-1:0]          wdata,
 output  wire                        wfull,rempty,
 output  wire   [WIDTH-1:0]          rdata                    

);

//*************** internal signals ***************//

wire         [ADDR-1:0]             raddr,waddr;

wire         [ADDR:0]               rq2_wptr,wq2_rptr,wptr,rptr;          



//*************** Port Mapping For Read pointer & empty logic unit ***************//

rptr_empty  # ( ADDR) U0_rptr_empty (
 .rclk(rclk),
 .rrst_n(rrst_n),
 .rinc(rinc), 
 .rempty(rempty),
 .rptr(rptr),
 .rq2_wptr(rq2_wptr),
 .raddr(raddr)
);

//*************** Port Mapping For write pointer & full logic unit ***************//

wptr_full  # ( ADDR) U0_wptr_full (
 .wclk(wclk),
 .wrst_n(wrst_n),
 .winc(winc), 
 .wfull(wfull),
 .wptr(wptr),
 .wq2_rptr(wq2_rptr),
 .waddr(waddr)
);

//*************** Port Mapping For memory of fifo unit ***************//

fifo_mem  # ( WIDTH ,ADDR ) U0_fifo_mem (
 .wclk(wclk),
 .wrst_n(wrst_n),
 .wclken(winc), 
 .raddr(raddr),
 .waddr(waddr),
 .wfull(wfull),
 .rdata(rdata),
 .wdata(wdata)
);

//*************** Port Mapping For Multi flop synchronizer (read to write domain) unit ***************//

sync_r2w  # ( ADDR) U0_sync_r2w (
 .wclk(wclk),
 .wrst_n(wrst_n),
 .rptr(rptr),
 .wq2_rptr(wq2_rptr)
);

//*************** Port Mapping For Multi flop synchronizer (read to write domain) unit ***************//

sync_w2r  # ( ADDR) U0_sync_w2r (
 .rclk(rclk),
 .rrst_n(rrst_n),
 .wptr(wptr),
 .rq2_wptr(rq2_wptr)
);

endmodule