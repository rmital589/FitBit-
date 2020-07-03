module Fitbit_Top (CLK, RESET, Start,Mode, steps_over, high_activity);
input CLK,RESET,Start;
input [1:0] Mode;
wire Pulse;
output [3:0] steps_over;
output [27:0] high_activity;
PulseGenerator PG (Start, CLK, RESET, Mode, Pulse);
High_activity_64 HA (CLK, RESET, Pulse, high_activity);
Steps_Over_32 SO (CLK,RESET,Pulse,steps_over);
endmodule
