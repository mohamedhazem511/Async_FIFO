/*
   ******  Multi flop synchronizer Block ******
   by:
       Mohamed Hazem Mamdouh
       28-1-2022
       5:18 PM   
*/

module sync_r2w # (
                      parameter ADDR  = 3
                  )

(
    input  wire                        wclk,
    input  wire                        wrst_n,
    input  wire  [ADDR:0]              rptr,
    output reg   [ADDR:0]              wq2_rptr

);


// internal signal

reg        [ADDR:0]            wq1_rptr;


//----------------- Multi flop synchronizer --------------//



always@(posedge wclk or negedge wrst_n)

  begin
  if(!wrst_n)
  begin
  wq2_rptr <= 0;
  wq1_rptr <= 0;
  end
  else
  begin
  {wq2_rptr,wq1_rptr} <= {wq1_rptr,rptr};                // synchronize the read pointer into the write-clock domain by 2 dff
  end
  end
 

endmodule