module v7404 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8, pin10, pin12);
	input logic pin1;
	output logic pin2;
	input logic pin3;
	output logic pin4;
	input logic pin5;
	output logic pin6;
	input logic pin9;
	output logic pin8;
	input logic pin11;
	output logic pin10;
	input logic pin13;
	output logic pin12;
	
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;

endmodule;

module v7408 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8, pin10, pin12);

	input logic pin1;
	input logic pin2;
	output logic pin3;
	input logic pin4;
	input logic pin5;
	output logic pin6;
	input logic pin10;
	input logic pin9;
	output logic pin8;
	input logic pin13;
	input logic pin12;
	output logic pin11;
	
	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin9 & pin10;
	assign pin11 = pin12 & pin13;

endmodule;

module v7432 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8, pin10, pin12);

	input logic pin1;
	input logic pin2;
	output logic pin3;
	input logic pin4;
	input logic pin5;
	output logic pin6;
	input logic pin10;
	input logic pin9;
	output logic pin8;
	input logic pin13;
	input logic pin12;
	output logic pin11;
	
	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;

endmodule;

module mux2to1(x, y, s, m);

	logic Connection;
	logic Connection2;
	logic Connection3;

	input logic x;
	input logic y;
	input logic s;
	output logic m;
	
	v7404 B1(
		.pin1(s),
		.pin2(Connection)
	);
	
	v7408 B2(
		.pin1(x),
		.pin2(Connection),
		.pin3(Connection2)
	);
	
	v7408 B3(
		.pin1(s),
		.pin2(y),
		.pin3(Connection3)
	);
	
	v7432 B4(
		.pin1(Connection2),
		.pin2(Connection3),
		.pin3(m)
	);
	

endmodule;