module High_activity_64 (CLK, RESET, Pulse, high_activity_over);
input CLK;
input RESET;
input Pulse;
output [13:0] high_activity_over;
reg [27:0] pulse_counter;
reg [27:0] seconds_counter;
reg [13:0] high_activity;
reg [13:0] last_activity;
wire secCLK;
wire flag;

divider d3(CLK,secCLK);
reg seconds_raise;
reg [27:0] first_pulse_counter;
reg [27:0] min_counter; 

assign flag = secCLK~^Pulse;
initial 
begin 
min_counter<=0;
pulse_counter <= 0;
high_activity <= 0;
last_activity<=0;
seconds_counter<=0;
seconds_raise<=0;
first_pulse_counter<=0;
end


always @(posedge CLK) //for counting seconds
begin 
if(~RESET)
begin 
	if(seconds_counter == 1000)//100000000
	begin
	seconds_counter <=0;
	end
	else
	seconds_counter <=seconds_counter+1;
	
	
end
else
seconds_counter<=0;
end 


always @(negedge secCLK) //for counting minutes
begin 
if(~RESET)
begin 
	if(min_counter== 60)//100000000
	begin
	min_counter <=0;
	end
	else
	min_counter<=min_counter+1;
	
	
end
else
min_counter<=0;
end 

always @(negedge flag) // finding the first pulse after 1 second
begin
if(~RESET)
begin
	if(seconds_raise)
	begin
	first_pulse_counter<=first_pulse_counter+1;
	end
	else
	first_pulse_counter<=0;
end
else
first_pulse_counter<=0;
end

always @(posedge CLK) // Pulse between 2 seconds
begin
if(~RESET)
begin
	if(seconds_counter >=500 &&seconds_counter<=1000)
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

always @(negedge secCLK) // setting high activity every second
begin 
if(~RESET)
begin
		if(min_counter==60)
	        begin	
		
			if(high_activity == 60)
			last_activity<=60+last_activity;
		

	        end
	        if(pulse_counter>=64)
		begin
			if(last_activity>=60 && high_activity >= 60)
			begin
			last_activity<=last_activity+1;
			high_activity<=high_activity+1;
			end
			else
			begin
			high_activity<=high_activity+1;
			end
		end
		if(pulse_counter<64)
		high_activity<=0;
	        
	
end
else
begin
high_activity<=0;
last_activity<=0;
end
end



always @(posedge Pulse) // for counting incoming Pulses
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


assign high_activity_over = last_activity;
endmodule

