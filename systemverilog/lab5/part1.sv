module DFF (
	input logic clk ,
	input logic reset_b ,
	input logic d,
	output logic q);
	
	always_ff @(posedge clk)
		begin
			if (reset_b) q <= 1'b0;
			else q <= d;
		end
endmodule

module T_flip_flop (
	input logic clk ,
	input logic reset_b ,
	input logic T,
	output logic q);

	logic temp;
	assign temp = T ^ q;

	DFF u0(clk, reset_b, temp, q);
endmodule

module part1 (
	input logic Clock,
	input logic Enable,
	input logic Reset,
	output logic [7:0] CounterValue
);
	logic T1, T2, T3, T4, T5, T6, T7;

	assign T0 = Enable;
	assign T1 = CounterValue[0] & T0;
	assign T2 = CounterValue[1] & T1;
	assign T3 = CounterValue[2] & T2;
	assign T4 = CounterValue[3] & T3;
	assign T5 = CounterValue[4] & T4;
	assign T6 = CounterValue[5] & T5;
	assign T7 = CounterValue[6] & T6;

	T_flip_flop u0(Clock, Reset, T0, CounterValue[0]);
	T_flip_flop u1(Clock, Reset, T1, CounterValue[1]);
	T_flip_flop u2(Clock, Reset, T2, CounterValue[2]);
	T_flip_flop u3(Clock, Reset, T3, CounterValue[3]);
	T_flip_flop u4(Clock, Reset, T4, CounterValue[4]);
	T_flip_flop u5(Clock, Reset, T5, CounterValue[5]);
	T_flip_flop u6(Clock, Reset, T6, CounterValue[6]);
	T_flip_flop u7(Clock, Reset, T7, CounterValue[7]);
endmodule
