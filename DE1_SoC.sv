/* Top-level module for DE1-SoC hardware */
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input CLOCK_50;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input  logic [3:0] KEY;
	input  logic [9:0] SW;

	wire [31:0] clk_divided;
	clock_divider cdiv (CLOCK_50, clk_divided);
	wire clk;
	assign clk = clk_divided[15]; //CLOCK_50;
		
	// inputs: 
	// SW0: reset
	// KEY0: increase seg7a
	// KEY1: increase seg7b
	// KEY2: increase seg7o
	// KEY3: increase seg7x
	wire reset, inc_a, inc_b, inc_o, inc_x;
	assign reset = SW[0];
	dff inc_a_ff(.clk(clk), .d(~KEY[0]), .q(inc_a), .prn(~reset), .clrn(~reset));
	dff inc_b_ff(.clk(clk), .d(~KEY[1]), .q(inc_b), .prn(~reset), .clrn(~reset));
	dff inc_o_ff(.clk(clk), .d(~KEY[2]), .q(inc_o), .prn(~reset), .clrn(~reset));
	dff inc_x_ff(.clk(clk), .d(~KEY[3]), .q(inc_x), .prn(~reset), .clrn(~reset));

	// incrementing registers to hold test values
	wire [4:0] a_u; // uncasted
	seg7::seg7_a_t a;
	assign a = seg7::seg7_a_t'(a_u);
	wire [3:0] b;
	wire [3:0] o;
	wire [3:0] x;
	inc_ctr #(.MAXVAL(5'd22)) ctr_a(.clk, .reset, .inc(inc_a), .count(a_u));
	inc_ctr #(.MAXVAL(1'b1)) ctr_b(.clk, .reset, .inc(inc_b), .count(b));
	inc_ctr #(.MAXVAL(3'd7)) ctr_o(.clk, .reset, .inc(inc_o), .count(o));
	inc_ctr #(.MAXVAL(4'd15)) ctr_x(.clk, .reset, .inc(inc_x), .count(x));

	// outputs:
	// HEX0: seg7a
	// HEX1: seg7b
	// HEX2: seg7o
	// HEX3: seg7x
	seg7a s7a (.val(a), .leds(HEX0));
	seg7b s7b (.val(b), .leds(HEX1));
	seg7o s7o (.val(o), .leds(HEX2));
	seg7x s7x (.val(x), .leds(HEX3));

	// turn off HEX4, HEX5
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
endmodule  // DE1_SoC

// Counter with increment and reset signal, only increments if not increment on prev clock.
module inc_ctr #(parameter MAXVAL)
(
	input wire clk, reset,
    input wire inc,
    output logic [$clog2(MAXVAL)-1:0] count
);
    // Declare sizes to avoid "truncated value with size 32..." warning
    wire [$clog2(MAXVAL)-1:0] unit = 1;
    wire [$clog2(MAXVAL)-1:0] zero = 0;
    wire [$clog2(MAXVAL)-1:0] maxval = MAXVAL;

    reg [$clog2(MAXVAL)-1:0] inner;
	reg prev_inc;

    // Incrementer logic
    always_comb 
        if (inc & ~prev_inc) count = inner == maxval ? maxval : inner + unit;
        else count = inner;

    // register update
    always_ff @(posedge clk) begin
		inner <= reset ? zero : count;
		prev_inc <= inc;
	end
endmodule

// divided_clocks[0]=25MHz, [1]=12.5Mhz, ... [23]=3Hz, [24]=1.5Hz, [25]=0.75Hz 
module clock_divider (clock, divided_clocks);
	input clock;
	output reg [31:0] divided_clocks;
	
	initial
		divided_clocks = 0;
		
	always_ff @(posedge clock)
		divided_clocks = divided_clocks + 1;
endmodule 