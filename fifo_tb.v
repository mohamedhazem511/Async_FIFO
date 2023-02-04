`timescale 1ns / 1ps


module fifo_tb();

parameter      WIDTH=8 , DEPTH=8 , ADDR = 3;

//input & outpot declerastion

   reg                 rclk_tb;
   reg                 wclk_tb;
   reg                 rrst_n_tb;
   reg                 wrst_n_tb;
// read and write command
   reg                 rinc_tb;
   reg                 winc_tb;

   reg  [WIDTH-1:0]    wdata_tb;

   wire [WIDTH-1:0]    rdata_tb;
   wire                wfull;
   wire                rempty;
   

// initial condition
initial
begin
 rclk_tb  = 1'b0;
 wclk_tb  = 1'b0;
 rinc_tb  = 1'b0;
 winc_tb  = 1'b0;
 wdata_tb = 'd104;
end

 

//reset block
initial
begin
 rrst_n_tb  = 1'b1;
 wrst_n_tb  = 1'b1;
 #1 
 rrst_n_tb = 1'b0;
 wrst_n_tb = 1'b0; 
 #1 
 rrst_n_tb = 1'b1;
 wrst_n_tb = 1'b1;
end



// testing 
initial
begin // it's empty at the begin 

// write untill it's full 
  #2.5 
  if( wfull==0 )
        begin 
        wdata_tb = 'd77;  // M
        winc_tb  = 1'b1;  
        end              
  #3.5  
  if( wfull==0 )
        begin
        wdata_tb = 'd100;
        winc_tb  =  1'b0;  
        end                // shouldn't write d
  #8 
  if( wfull==0 )
        begin
        winc_tb  = 1'b1;  
        wdata_tb = 'd79;  // O
        end                
  #8  
  if( wfull==0 )
        wdata_tb = 'd72;   // H
  #8  
  if( wfull==0 )
        wdata_tb = 'd65;   // A
  #8 
  if( wfull==0 )
        wdata_tb = 'd77;  // M
  #8 
  if( wfull==0 )
        wdata_tb = 'd77;  // M
  #8 
  if( wfull==0 )
        wdata_tb = 'd69;  // E
  #8 
  if( wfull==0 )
        wdata_tb = 'd68;  // D
  wait( wfull );
        winc_tb  = 1'b0;
        
        
        
        /// reading 
        // will begin two clock later cause of syncroizing
  #2 
        rinc_tb = 1'b1 ;       //will read until it's empty  
        
        //after 2 cycle of

  wait( rempty );
    
      
        
        // reading and writing simultaneously
        //it's reading cause rinc is one
  #8 
  if( wfull==0 )
    begin 
         wdata_tb = 'd79;
         winc_tb  = 1'b1;  
    end 
  #8 
  if( wfull==0 )
         wdata_tb = 'd114;

  #8 
  if( wfull==0 )
         wdata_tb = 'd105;
  #8 
  if( wfull==0 )
         wdata_tb = 'd103;
  #8 
  if( wfull==0 )
         wdata_tb = 'd105;
  #8 
  if( wfull==0 )
         wdata_tb = 'd110;
  #8 
  if( wfull==0 )
         wdata_tb = 'd97;
  #8 
  if( wfull==0 )
         wdata_tb = 'd108;
  #8 
  if( wfull==0 )
         wdata_tb = 'd95;
  #8 
  if( wfull==0 )
         wdata_tb = 'd70;
  #8 
  if( wfull==0 )
         wdata_tb = 'd73;
  #8 
  if( wfull==0 )
         wdata_tb = 'd70;
  #8 
  if( wfull==0 )
         wdata_tb = 'd73;
  #8 
  if( wfull==0 )
         wdata_tb = 'd73;
  #2 
  winc_tb = 1'b0;
  wait( rempty );

  #400
   $stop ;
                      
             
        
end 

////////////////// Clock Generator  ////////////////////


always #9 rclk_tb = ~rclk_tb ;
always #4 wclk_tb = ~wclk_tb ; //writing clock is faster



fifo_top #(     .WIDTH(WIDTH),
                .DEPTH(DEPTH),
                .ADDR(ADDR)
               ) 
fifo_tb( .rclk(rclk_tb),
         .wclk(wclk_tb),
         .rinc(rinc_tb),
         .winc(winc_tb),
         .rrst_n(rrst_n_tb),
         .wrst_n(wrst_n_tb),
         .wdata(wdata_tb),
         .rdata(rdata_tb),
         .wfull(wfull),
         .rempty(rempty)   
    );







endmodule