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
    output logic Enable);	
logic [10:0] count_to;
logic [10:0] count;
assign count_to = CLOCK_FREQUENCY /2;
counter #(.N(11)) u0(count_to, ClockIn, Reset, count);
assign Enable = (count == 'b0)?'1:'0;
endmodule

module register
(input logic clk,
input logic enable,
input logic Reset, 
input logic ParallelLoadn,
input logic [11:0] load,
output logic [11:0] Q);

always_ff @(posedge clk) begin
	if (Reset) Q <= 12'b000000000000;
	else if (ParallelLoadn) Q <= load;
end

always_ff @(posedge enable) begin
	if (~Reset & ~ParallelLoadn) Q <= Q << 1;
end

endmodule


module part3
#(parameter CLOCK_FREQUENCY=500)(
input logic ClockIn,
input logic Reset,
input logic Start,
input logic [2:0] Letter,
output logic DotDashOut,
output logic NewBitOut
);

logic [11:0] pattern;
// logic enable;
logic[11:0] to_display;
always_comb
	case (Letter)
		3'b000: pattern = 12'b101110000000;
		3'b001: pattern = 12'b111010101000;
		3'b010: pattern = 12'b111010111010;
		3'b011: pattern = 12'b111010100000;
		3'b100: pattern = 12'b100000000000;
		3'b101: pattern = 12'b101011101000;
		3'b110: pattern = 12'b111011101000;
		3'b111: pattern = 12'b101010100000;
		default: pattern = 12'b000000000000;
	endcase  

register u0(ClockIn, NewBitOut, Reset, Start, pattern, to_display);

RateDivider #(.CLOCK_FREQUENCY(CLOCK_FREQUENCY)) u1(ClockIn, (Reset | Start), NewBitOut);

// always_ff @(posedge ClockIn)
// 	NewBitOut <= enable;

always_ff @(posedge Reset)
	DotDashOut <= 0;

always_ff @(posedge NewBitOut)
	DotDashOut <= to_display[11];

endmodule 

