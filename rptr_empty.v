/*
   ******  read pointer &  generate empty logic block ******
   by:
       Mohamed Hazem Mamdouh
       28-1-2022
       5:18 PM   
*/


////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
///////////////// read pointer &  generate empty logic module //////////////////////
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

module rptr_empty # (parameter    ADDR = 3
                               )
(
    input  wire                          rclk,rrst_n,
    input  wire                          rinc,
    input  wire    [ADDR:0]              rq2_wptr,
    output reg     [ADDR:0]              rptr,
    output reg                           rempty,
    output wire    [ADDR-1:0]            raddr
);

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////// internal signal ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////


   wire empty_flag;

   wire [ADDR:0]  rgraynext, rbinnext;

   reg  [ADDR:0]  rbin;

  always @(posedge rclk or negedge rrst_n) 
	begin
    if (!rrst_n) 
		  begin
          rempty <= 1'b1;
		  end
	  else 
          begin
          rempty <= empty_flag; 
          end
    end

  always @(posedge rclk or negedge rrst_n) 
	begin
    if (!rrst_n) 
		  begin
          rptr   <= 'b0;
          rbin   <= 'b0;
		  end
	  else 
          begin
          rptr   <= rgraynext;
          rbin   <= rbinnext; 
          end
    end
   
    assign empty_flag = (rgraynext == rq2_wptr) ;            // ganerate empty logic 

    assign rgraynext  = ((rbinnext>>1) ^ (rbinnext)) ;  // binnary to gray

    assign rbinnext   = ((rinc & ~rempty)+ rbin) ;      // increment of read pointer

    assign raddr      = rbin[ADDR-1:0] ;                // read address


endmodule