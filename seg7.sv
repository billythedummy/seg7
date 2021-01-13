package seg7;
    // Alphabet type, 23/26 alphabets supported
    typedef enum {
        SEG7_A_A, 
        SEG7_A_B,
        SEG7_A_C,
        SEG7_A_D,
        SEG7_A_E,
        SEG7_A_F,
        SEG7_A_G,
        SEG7_A_H,
        SEG7_A_I,
        SEG7_A_J,
        SEG7_A_K,
        SEG7_A_L,
        SEG7_A_N,
        SEG7_A_O,
        SEG7_A_P,
        SEG7_A_Q,
        SEG7_A_R,
        SEG7_A_S,
        SEG7_A_T,
        SEG7_A_U,
        SEG7_A_V,
        SEG7_A_Y,
        SEG7_A_Z
    } seg7_a_t;

    // Common display constants
    localparam SEG7_DISP_ZERO = 7'b1000000;
    localparam SEG7_DISP_ONE = 7'b1111001;
    localparam SEG7_DISP_TWO = 7'b0100100;
    localparam SEG7_DISP_THREE = 7'b0110000;
    localparam SEG7_DISP_FOUR = 7'b0011001;
    localparam SEG7_DISP_FIVE = 7'b0010010;
    localparam SEG7_DISP_SIX = 7'b0000010;
    localparam SEG7_DISP_SEVEN = 7'b1111000;
    localparam SEG7_DISP_EIGHT = 7'b0000000;
    localparam SEG7_DISP_NINE = 7'b0010000;
    localparam SEG7_DISP_A = 7'b0001000; // A
    localparam SEG7_DISP_B = 7'b0000011; // b
    localparam SEG7_DISP_C = 7'b1000110; // C
    localparam SEG7_DISP_D = 7'b0100001; // d
    localparam SEG7_DISP_E = 7'b0000110; // E
    localparam SEG7_DISP_F = 7'b0001110; // F
    localparam SEG7_DISP_G = SEG7_DISP_SIX; // G
    localparam SEG7_DISP_H = 7'b0001001; // H
    localparam SEG7_DISP_I = 7'b1001111; // I, left aligned to diff from 1
    localparam SEG7_DISP_J = 7'b1100001; // J
    localparam SEG7_DISP_K = 7'b0000111; // k, doesn't look quite right
    localparam SEG7_DISP_L = 7'b1000111; // L
    // M unsupported
    localparam SEG7_DISP_N = 7'b0101011; // n
    localparam SEG7_DISP_O = 7'b0100011; // o
    localparam SEG7_DISP_P = 7'b0001100; // P
    localparam SEG7_DISP_Q = 7'b0011000; // q. doesnt look quite right
    localparam SEG7_DISP_R = 7'b0101111; // r
    localparam SEG7_DISP_S = SEG7_DISP_FIVE; // S
    localparam SEG7_DISP_T = SEG7_DISP_SEVEN; // T, 7 looks closest
    localparam SEG7_DISP_U = 7'b1100011; // u
    localparam SEG7_DISP_V = 7'b1000001; // V
    // W unsupported
    // X unsupported
    localparam SEG7_DISP_Y = 7'b0010001; // y
    localparam SEG7_DISP_Z = SEG7_DISP_TWO; // Z, 2 looks closest
endpackage : seg7

import seg7::*;

// Alphabet display
module seg7a (
    input seg7_a_t val,
    output logic [6:0] leds
);
    always_comb
        case (val)
            SEG7_A_A: leds = SEG7_DISP_A;
            SEG7_A_B: leds = SEG7_DISP_B;
            SEG7_A_C: leds = SEG7_DISP_C;
            SEG7_A_D: leds = SEG7_DISP_D;
            SEG7_A_E: leds = SEG7_DISP_E;
            SEG7_A_F: leds = SEG7_DISP_F;
            SEG7_A_G: leds = SEG7_DISP_G;
            SEG7_A_H: leds = SEG7_DISP_H;
            SEG7_A_I: leds = SEG7_DISP_I;
            SEG7_A_J: leds = SEG7_DISP_J;
            SEG7_A_K: leds = SEG7_DISP_K;
            SEG7_A_L: leds = SEG7_DISP_L;
            SEG7_A_N: leds = SEG7_DISP_N;
            SEG7_A_O: leds = SEG7_DISP_O;
            SEG7_A_P: leds = SEG7_DISP_P;
            SEG7_A_Q: leds = SEG7_DISP_Q;
            SEG7_A_R: leds = SEG7_DISP_R;
            SEG7_A_S: leds = SEG7_DISP_S;
            SEG7_A_T: leds = SEG7_DISP_T;
            SEG7_A_U: leds = SEG7_DISP_U;
            SEG7_A_V: leds = SEG7_DISP_V;
            SEG7_A_Y: leds = SEG7_DISP_Y;
            SEG7_A_Z: leds = SEG7_DISP_Z;
        endcase	
endmodule  // seg7a

// Binary display
module seg7b (
    input wire val,
    output logic [6:0] leds
);
    always_comb
        case (val)
            1'b0: leds = SEG7_DISP_ZERO;
            1'b1: leds = SEG7_DISP_ONE;
        endcase	
endmodule  // seg7b

// Octal display
module seg7o (
    input wire [2:0] val,
    output logic [6:0] leds
);
    always_comb
        case (val)
            3'o0: leds = SEG7_DISP_ZERO;
            3'o1: leds = SEG7_DISP_ONE;
            3'o2: leds = SEG7_DISP_TWO;
            3'o3: leds = SEG7_DISP_THREE;
            3'o4: leds = SEG7_DISP_FOUR;
            3'o5: leds = SEG7_DISP_FIVE;
            3'o6: leds = SEG7_DISP_SIX;
            3'o7: leds = SEG7_DISP_SEVEN;
        endcase	
endmodule  // seg7o

// Hexadecimal display
module seg7x (
    input wire [3:0] val,
    output logic [6:0] leds
);
    always_comb
        case (val)
            4'h0: leds = SEG7_DISP_ZERO;
            4'h1: leds = SEG7_DISP_ONE;
            4'h2: leds = SEG7_DISP_TWO;
            4'h3: leds = SEG7_DISP_THREE;
            4'h4: leds = SEG7_DISP_FOUR;
            4'h5: leds = SEG7_DISP_FIVE;
            4'h6: leds = SEG7_DISP_SIX;
            4'h7: leds = SEG7_DISP_SEVEN;
            4'h8: leds = SEG7_DISP_EIGHT;
            4'h9: leds = SEG7_DISP_NINE;
            4'hA: leds = SEG7_DISP_A;
            4'hB: leds = SEG7_DISP_B;
            4'hC: leds = SEG7_DISP_C;
            4'hD: leds = SEG7_DISP_D;
            4'hE: leds = SEG7_DISP_E;
            4'hF: leds = SEG7_DISP_F;
        endcase	
endmodule  // seg7x
