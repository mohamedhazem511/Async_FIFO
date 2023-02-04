/*
   ******  Multi flop synchronizer Block ******
   by:
       Mohamed Hazem Mamdouh
       28-1-2022
       5:18 PM   
*/
`timescale 1us/1ns
module sync_w2r # (
                        parameter ADDR  = 3
                  )

(
    input  wire                        rclk,
    input  wire                        rrst_n,
    input  wire  [ADDR:0]              wptr,
    output reg   [ADDR:0]              rq2_wptr

);


// internal signal

reg        [ADDR:0]            rq1_wptr;


//----------------- Multi flop synchronizer --------------//


always@(posedge rclk or negedge rrst_n)

  begin
  if(!rrst_n)
  begin
  rq2_wptr <= 0;
  rq1_wptr <= 0;
  end
  else
  begin
  {rq2_wptr,rq1_wptr} <= {rq1_wptr,wptr};        // synchronize the write pointer into the read-clock domain by 2 dff
  end
  end
 

endmodule