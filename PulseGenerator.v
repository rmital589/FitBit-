`define time_constant 1000//100000000
module PulseGenerator(Start, CLK, RESET, Mode, Pulse);
input Start;
input CLK;
input RESET;
input [1:0] Mode;
output Pulse;
reg Steps;
reg[27:0] counter;
reg[27:0] counter2;
reg[1:0] lastMode;

initial 
begin 
counter<=0;
Steps<=1;
counter2<=0;
lastMode <= Mode;
end



always @(posedge CLK)
begin
if(~RESET)
begin 
	if(Mode == 2'b11)
	begin 
	counter2<=counter2+1;
	end
	else 
	counter2<=0;
end
else
counter2<=0;
end


always @(posedge CLK)
begin 
if(Start)
begin
if(lastMode!=Mode)
counter<=0;
else
begin 
case(Mode)
2'b00 :  begin 
	if(counter == 16 )//1562500)
	begin
	counter<=1;
	Steps<=~Steps;
	end
	else 
	begin	
	counter<=counter+1;
	end
      end
2'b01 :  begin 
	if(counter == 8)//781250)
	begin
	counter<=1;
	Steps<=~Steps;
	end
	else 
	begin	
	counter<=counter+1;
	end
      end
2'b10 :  begin 
	if(counter == 4)//4390625)
	begin
	counter<=1;
	Steps<=~Steps;
	end
	else 
	begin
	counter<=counter+1;
	end
      end
2'b11 :  begin 
	if(counter2 <= `time_constant)
	begin
		if(counter2 == `time_constant)
			counter <= 0;
		else
		begin
	 		if(counter == 25)//2500000)
			begin
			counter<=1;
			Steps<=~Steps;
			end
			else 
			begin
			counter<=counter+1;
			end
		end
	end
	if(counter2 > `time_constant && counter2 <= 2*`time_constant)
	begin
		if(counter2 == 2*`time_constant)
			counter <=0 ;
		else
		begin
	 		if(counter ==15)//1515152)
			begin
			counter<=1;
			Steps<=~Steps;
			end
			else 
			begin
			counter<=counter+1;		
			end
		end	
	end
	if(counter2 > 2*`time_constant && counter2 <= 3*`time_constant)
	begin
		if(counter2 == 3*`time_constant)
			counter <=0 ;
		else
		begin
		
	 		if(counter==8)//757576)
			begin
			counter<=1;
			Steps<=~Steps;
			end
			else 
			begin
			counter<=counter+1;
			end
		end	
	end
	if(counter2 > 3*`time_constant && counter2 <= 4*`time_constant)
	begin
		if(counter2 == 4*`time_constant)
			counter <=0 ;
		else
		begin
	 		if(counter == 19)//1851852)
			begin
			counter<=1;
			Steps<=~Steps;
			end
			else 
			begin
			counter<=counter+1;
			end	
		end
	end	 
	if(counter2 > 4*`time_constant && counter2 <= 5*`time_constant)
	begin
		if(counter2 == 5*`time_constant)
			counter <=0 ;
		else
		begin
	 		if(counter == 7)//714286)
			begin
			counter<=1;
			Steps<=~Steps;
			end
			else 
			begin
			counter<=counter+1;
			end
		end	
	end
	if(counter2 > 5*`time_constant && counter2 <= 6*`time_constant)
	begin
		if(counter2 == 6*`time_constant)
			counter <=0 ;
		else
		begin
	 		if(counter == 17)//1666667)
			begin
			counter<=1;
			Steps<=~Steps;
			end
			else 
			begin
			counter<=counter+1;
			end	
		end
	end
	if(counter2 > 6*`time_constant && counter2 <= 7*`time_constant)
	begin
		if(counter2 == 7*`time_constant)
			counter <=0 ;
		else
		begin
	 		if(counter == 26)//2631579)
			begin
			counter<=1;
			Steps<=~Steps;
			end
			else 
			begin
			counter<=counter+1;
			end
		end	
	end
	if(counter2 > 7*`time_constant && counter2 <= 8*`time_constant)
	begin
		if(counter2 == 8*`time_constant)
			counter <=0 ;
		else
		begin
	 		if(counter == 17)//1666667)
			begin
			counter<=1;
			Steps<=~Steps;
			end
			else 
			begin
			counter<=counter+1;
			end
		end	
	end
	if(counter2 > 8*`time_constant && counter2 <= 9*`time_constant)
	begin
		if(counter2 == 9*`time_constant)
			counter <=0 ;
		else
		begin
	 		if(counter == 15)//15151512)
			begin
			counter<=1;
			Steps<=~Steps;
			end
			else 
			begin
			counter<=counter+1;
			end
		end	
	end
	if(counter2 > 9*`time_constant && counter2<=73*`time_constant)
	begin
		if(counter2 == 73*`time_constant)
			counter <=0 ;
		else
		begin
	 		if(counter == 7)//724638)
			begin
			counter<=1;
			Steps<=~Steps;
			end
			else 
			begin
			counter<=counter+1;
			end	
		end
	end
	if(counter2 > 73*`time_constant && counter2<=79*`time_constant)
	begin
		if(counter2 == 79*`time_constant)
			counter <=0 ;
		else
		begin
	 		if(counter == 15)//1470588)
			begin
			counter<=1;
			Steps<=~Steps;
			end
			else 
			begin
			counter<=counter+1;
			end
		end	
        end
	if(counter2 > 79*`time_constant && counter2<=144*`time_constant)
	begin
		
	 	if(counter == 4)//403226)
		begin
		counter<=1;
		Steps<=~Steps;
		end
		else 
		begin
		counter<=counter+1;
		end	
	end
	if(counter2 >= 145*`time_constant)
	begin
	 	Steps<=0;
	end

end
endcase
end
end
else 
Steps<=0;
end 
assign Pulse = Steps;
endmodule
