
module part3(A, B, Function, ALUout);

	parameter N = 4;

	input logic [N-1:0] A, B;
	input logic [1:0] Function;
	output logic [N+N-1:0] ALUout;


	logic [N:0] s;
	assign s = A + B;

	logic y, z, y2, z2;
	
	assign y = |A;
	assign z = |B;

	assign y2 = &A;
	assign z2 = &B;

	always_comb
		case (Function)
			2'b00: ALUout = s;
			2'b01: ALUout =  y | z;
			2'b10: ALUout = y2 & z2;
			2'b11: ALUout = {A, B};
			default: ALUout = s;
		endcase


endmodule

