module FA(input logic a, b, cin, output logic s, cout);
	assign s = a^b^cin;
	assign cout = ((a^b)&cin) | (~(a^b)&b);
endmodule

module part1(a, b, c_in, s, c_out);
	input logic [3:0] a, b;
	input logic c_in;
	output logic [3:0] s, c_out;

	FA u0(a[0], b[0], c_in, s[0], c_out[0]);
	FA u1(a[1], b[1], c_out[0], s[1], c_out[1]);
	FA u2(a[2], b[2], c_out[1], s[2], c_out[2]);
	FA u3(a[3], b[3], c_out[2], s[3], c_out[3]);
endmodule

module mux(KEY, A, B, s, res);
	input logic [1:0] KEY;
	input logic [3:0] A;
	input logic [3:0] B;
	input logic [7:0] s;
	output logic [7:0] res;

	logic y, z, y2, z2;
	
	assign y = |A;
	assign z = |B;

	assign y2 = &A;
	assign z2 = &B;

	always_comb
		case (KEY)
			2'b00: res = s;
			2'b01: res =  y | z;
			2'b10: res = y2 & z2;
			2'b11: res = {A, B};
			default: res = s;
		endcase
endmodule

module part2(A, B, Function, ALUout);
	input logic [3:0] A, B;
	input logic [1:0] Function;
	output logic [7:0] ALUout;

	logic [3:0] s;
	logic [3:0] cout;

	part1 u0(A, B, 0, s, cout);

	mux u1(Function, A, B, {3'b000, cout[3], s}, ALUout);
endmodule
