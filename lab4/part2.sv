module DFF(
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

module register(input logic [7:0] in, input logic clock, input logic reset, output logic [7:0] out);
	DFF u0(clock, reset, in[0], out[0]);
	DFF u1(clock, reset, in[1], out[1]);
	DFF u2(clock, reset, in[2], out[2]);
	DFF u3(clock, reset, in[3], out[3]);
	DFF u4(clock, reset, in[4], out[4]);
	DFF u5(clock, reset, in[5], out[5]);
	DFF u6(clock, reset, in[6], out[6]);
	DFF u7(clock, reset, in[7], out[7]);
endmodule

module mux(KEY, A, B, s, res);
	input logic [1:0] KEY;
	input logic [3:0] A;
	input logic [3:0] B;
	input logic [7:0] s;
	output logic [7:0] res;

	logic [7:0] p;
	assign p = A * B;

	always_comb
		case (KEY)
			2'b00: res = s;
			2'b01: res =  p;
			2'b10: res = B << A;
			2'b11: res = res;
			default: res = s;
		endcase
endmodule

module ALU(A, B, Function, ALUout);
	input logic [3:0] A, B;
	input logic [1:0] Function;
	output logic [7:0] ALUout;

	logic [7:0] s;

	assign s = A + B;

	mux u1(Function, A, B, s, ALUout);
endmodule

module part2(input logic Clock, input logic Reset_b, input logic [3:0] Data, input logic [1:0] Function, output logic [7:0] ALUout);
	logic [7:0] temp;

	ALU u0(Data, ALUout[3:0], Function, temp);
	register u1(temp, Clock, Reset_b, ALUout);
endmodule
