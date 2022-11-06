//module counter
//#(parameter N = 8)(
//	input logic clk,
//	input logic reset,
//	output logic [N-1:0] q);
//
//	always_ff @(posedge clk, posedge reset)
//		if (reset) q <= 0;
//		else q <= q - 1;
//endmodule

module counter
#(parameter N = 8) (
input logic [N-1:0] parallel_uwu, 
input logic clk, 
input logic reset, 
output logic [N-1:0] q);

	always_ff @(posedge clk) begin
		if(reset) q <= parallel_uwu; 
		else q <= q - 1;
		if (q == 0) q <= parallel_uwu-1;
	end

endmodule

module RateDivider
#(parameter CLOCK_FREQUENCY = 500) (
    input logic ClockIn,
    input logic Reset,
    input logic [1:0] Speed,
    output logic Enable);

    logic [10:0] count_to;
    logic [10:0] count;

    always_comb
        case({Speed, (~(|count) | Reset)})
            3'b001: count_to = 1;
            3'b011: count_to = CLOCK_FREQUENCY;
            3'b101: count_to = CLOCK_FREQUENCY * 2;
            3'b111: count_to = CLOCK_FREQUENCY * 4;
            default: count_to = count_to;
        endcase

    counter #(.N(11)) u0(count_to, ClockIn, Reset, count);

    always_comb
        if (count_to == 1) Enable = ClockIn;
        else Enable = (count == 'b0)?'1:'0;
endmodule

module DisplayCounter (
	input logic Clock,
	input logic Reset,
	input logic EnableDC,
	output logic [3:0] CounterValue
);

	always_ff @(posedge Clock) begin
		if (Reset) CounterValue <= 0;
	end
	always_ff @(posedge EnableDC) begin
		if (~Reset) CounterValue <= CounterValue + 1;
	end
endmodule

module part2
#(parameter CLOCK_FREQUENCY = 500)(
	input logic ClockIn,
	input logic Reset,
	input logic [1:0] Speed,
	output logic [3:0] CounterValue);
	logic temp;
	RateDivider #(.CLOCK_FREQUENCY(CLOCK_FREQUENCY)) u0(ClockIn, Reset, Speed, temp);
	DisplayCounter u1(ClockIn, Reset, temp, CounterValue);
endmodule
