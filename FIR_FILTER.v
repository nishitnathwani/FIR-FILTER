module fir_4tap(input Clk,input signed [7:0] Xin,output reg signed [15:0] Yout);    
//Internal variables.
wire signed   [7:0] H0,H1,H2,H3;
wire signed   [15:0] MCM_block0,MCM_block1,MCM_block2,MCM_block3,shift_add_out1,shift_add_out2,shift_add_out3,Q1,Q2,Q3;    
//filter coefficient initializations.
//h(n) = [-1 -2 5 -1].
    assign H0 = -1;
    assign H1 = -2;
    assign H2 = 5;
    assign H3 = -1;
//Multiple constant multiplications.
    assign MCM_block3 = H3*Xin;
    assign MCM_block2 = H2*Xin;
    assign MCM_block1 = H1*Xin;
    assign MCM_block0 = H0*Xin;
//adders
    assign shift_add_out1 = Q1 + MCM_block2;
    assign shift_add_out2 = Q2 + MCM_block1;
   assign shift_add_out3 = Q3 + MCM_block0;    
//flipflop instantiations (for introducing a delay).
    DFF dff1 (.Clk(Clk),.D(MCM_block3),.Q(Q1));
    DFF dff2 (.Clk(Clk),.D(shift_add_out1),.Q(Q2));
    DFF dff3 (.Clk(Clk),.D(shift_add_out2),.Q(Q3));
//Assign the last adder output to final output.
    always@ (posedge Clk)
        Yout <= shift_add_out3;
endmodule
module DFF(input Clk,input [15:0] D,output reg [15:0] Q);
    
    always@ (posedge Clk)
        Q = D;
    
endmodule
 

module test_bench;

    // Inputs
    reg Clk;
    reg signed [7:0] Xin ;

    // Outputs
    wire signed [15:0] Yout;
	 integer outfile1,outfile2;

    // Instantiate the Unit Under Test (UUT)
    fir_4tap uut (
        .Clk(Clk), 
        .Xin(Xin), 
        .Yout(Yout)
    );
    
    //Generate a clock with 10 ns clock period.
    initial Clk = 0;
    always 
	 #5 Clk =~Clk;
	 
//Initialize and apply the inputs.
    initial begin
          Xin =0;  #40;
		
			  outfile1=$fopen("output.txt","w");
           outfile2=$fopen("input.txt","w");	
			$fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
          Xin =0.5; #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
          Xin =1;  #10;
			$fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal 
          Xin =1.5;  #10;
			$fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal 
          Xin =2; #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
          Xin =1.6; #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
          Xin =0.8;  #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
          Xin =0.5; #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
          Xin =0;  #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
          Xin =-0.5;  #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
			Xin =-1;  #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
			Xin =-1.2;  #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
			Xin =-2;  #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
			Xin =-1.7;  #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
			Xin =-1.2;  #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
			Xin =-0.8;  #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
			Xin =-0.4;  #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
			Xin =0;  #10;
			 $fwrite(outfile1,"%d\n",Xin);  //write as decimal
			$fwrite(outfile2,"%d\n",Yout);  //write as decimal
			
			$fclose(outfile1);
	        $fclose(outfile2);
    end    
endmodule
