module DFF(
	input logic clk ,
	input logic reset_b,
	input logic d,
	output logic q);
	
	always_ff @(posedge clk)
		begin
			if (reset_b) q <= 1'b0;
			else q <= d;
		end
endmodule

module subcircuit(input logic loadn, input logic loadleft, input logic D, input logic clock, input logic reset, input logic left, input logic right, output logic Q);
	logic temp;
	logic temp2;

	always_comb
		case (loadleft)
			0: temp = right;
			1: temp = left;
			default: temp = left;
		endcase

	always_comb
		case (loadn)
			0: temp2 = D;
			1: temp2 = temp;
			default: temp2 = temp;
		endcase

	DFF u0(clock, reset, temp2, Q);
endmodule

module cringe_subcircuit(input logic loadn, input logic loadleft, input logic D, input logic clock, input logic reset, input logic left, input logic right, input logic ASRight, output logic Q);
	logic temp;
	logic temp2;

	always_comb
		case ({loadleft, ASRight})
			2'b00: temp = right;
			2'b01: temp = right;
			2'b10: temp = left;
			2'b11: temp = Q;
			default: temp = left;
		endcase

	always_comb
		case (loadn)
			0: temp2 = D;
			1: temp2 = temp;
			default: temp2 = temp;
		endcase

	DFF u0(clock, reset, temp2, Q);
endmodule

module nuke(input logic loadn, input logic loadleft, input logic D, input logic clock, input logic reset, input logic left, input logic right, input logic ASRight, input logic is_MSB, output logic Q);
	logic temp;

	always_comb
		case ({loadn, loadleft, ASRight, is_MSB})
			4'b0000: temp = D;
			4'b0001: temp = D;
			4'b0010: temp = D;
			4'b0011: temp = D;
			4'b0100: temp = D;
			4'b0101: temp = D;
			4'b0110: temp = D;
			4'b0111: temp = D;
			4'b1000: temp = right;
			4'b1001: temp = right;
			4'b1010: temp = right;
			4'b1011: temp = right;
			4'b1100: temp = left;
			4'b1101: temp = left;

			4'b1110: temp = left;
			4'b1111: temp = Q;
			default: temp = D;
		endcase

	DFF u0(clock, reset, temp, Q);
endmodule

module part3(input logic clock, input logic reset, input logic ParallelLoadn, input logic RotateRight, input logic ASRight, input logic [3:0] Data_IN, output logic [3:0] Q);
	nuke u0(ParallelLoadn, RotateRight, Data_IN[0], clock, reset, Q[3], Q[1], ASRight, 1'b1, Q[0]);
	nuke u1(ParallelLoadn, RotateRight, Data_IN[1], clock, reset, Q[0], Q[2], ASRight, 1'b0, Q[1]);
	nuke u2(ParallelLoadn, RotateRight, Data_IN[2], clock, reset, Q[1], Q[3], ASRight, 1'b0, Q[2]);
	nuke u3(ParallelLoadn, RotateRight, Data_IN[3], clock, reset, Q[2], Q[0], ASRight, 1'b0, Q[3]);
endmodule
