/*
   ******  write pointer &  generate full logic block ******
   by:
       Mohamed Hazem Mamdouh
       28-1-2022
       5:18 PM   
*/


////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
///////////////// write pointer &  generate full logic module //////////////////////
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////



module wptr_full # (parameter    ADDR = 3
                               )
(
    input  wire                          wclk,wrst_n,
    input  wire                          winc,
    input  wire    [ADDR:0]              wq2_rptr,
    output reg     [ADDR:0]              wptr,
    output reg                           wfull,
    output wire    [ADDR-1:0]            waddr
);
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////// internal signal ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////


   wire full_flag;

   wire [ADDR:0]  wgraynext, wbinnext;

   reg  [ADDR:0]  wbin;

  always @(posedge wclk or negedge wrst_n) 
	begin
    if (!wrst_n) 
		  begin
          wfull <= 1'b0;
		  end
	  else 
          begin
          wfull <= full_flag; 
          end
    end

  always @(posedge wclk or negedge wrst_n) 
	begin
    if (!wrst_n) 
		  begin
          wptr   <= 'b0;
          wbin   <= 'b0;
		  end
	  else 
          begin
          wptr   <= wgraynext;
          wbin   <= wbinnext; 
          end
    end

    assign full_flag = (wgraynext == { ~wq2_rptr[ADDR:ADDR-1],wq2_rptr[ADDR-2:0]}) ;   // ganerate full logic

    assign wgraynext  = ((wbinnext>>1) ^ (wbinnext)) ;                          // binnary to gray

    assign wbinnext   = ((winc & ~wfull) + wbin) ;                              // increment of write pointer

    assign waddr      = wbin[ADDR-1:0] ;                                        // write address


endmodule