
module Steps_Over_32 (CLK,RESET,Pulse,steps_over);
input CLK,Pulse;
input RESET;
output [3:0] steps_over;
wire slowCLK;
divider d1 (CLK, slowCLK);
reg [27:0] pulse_counter;
reg [27:0] seconds_counter;
reg[27:0] clk_counter;
reg[27:0] first_pulse_counter;
reg seconds_raise;
reg [3:0] steps_per_sec;
wire flag;

initial 
begin
pulse_counter <= 0;
seconds_counter <= 0; 
steps_per_sec <= 0;
clk_counter<=0;
seconds_raise<=0;
 first_pulse_counter<=0;
end

assign flag = slowCLK~^Pulse;

always @(posedge CLK) 
begin 
if(~RESET)
begin 
	if(clk_counter==1000) //1000 is the frequency of CLK
	clk_counter<=0;
	else
	clk_counter<=clk_counter+1;

end 
else
clk_counter<=0;
end 

always @(posedge CLK) // Pulse between 2 seconds
begin
if(~RESET)
begin
	if(clk_counter >=500 && clk_counter<=1000)
	begin
	seconds_raise<=0;
	end
	else
	begin
	seconds_raise<=1;
	end
end
else
seconds_raise<=0;
end 

always @(negedge flag) // to check for first pulse after 1 second
begin
if(~RESET)
begin
	if(seconds_raise)
	begin
	 first_pulse_counter<= first_pulse_counter+1;
	end
	else
	 first_pulse_counter<=0;
end
else
first_pulse_counter<=0;
end

always @(posedge slowCLK) //to check for step over 32
begin 
if(~RESET)
begin 
	if(seconds_counter <= 9)
	begin
	seconds_counter <= seconds_counter + 1;
			if(pulse_counter >= 32) 
			begin
			steps_per_sec <= steps_per_sec + 1;
			end
	end
		
		
	
	
	
end
else
begin
steps_per_sec <= 0;
seconds_counter <= 0;
end
end

always @(posedge Pulse) // to count incoming pulses
begin
if(~RESET)
begin 
	if(first_pulse_counter==1)
	begin
	pulse_counter <= 0;
	end
	else
	pulse_counter<= pulse_counter+1; 
	end
else
pulse_counter<=0;
end 

assign steps_over = steps_per_sec;


endmodule
