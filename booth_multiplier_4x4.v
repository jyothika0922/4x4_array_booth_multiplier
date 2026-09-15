
module booth_multiplier_4x4 (
    input  signed [3:0] M,
    input  signed [3:0] Q,
    output reg signed [7:0] Product
);

    reg signed [4:0] A;
    reg signed [4:0] M_ext;
    reg [3:0] Q_reg;
    reg Q_minus1;

    integer i;

    always @(*) begin

        // Initialization
        A        = 5'b00000;
        M_ext    = {M[3], M};
        Q_reg    = Q;
        Q_minus1 = 1'b0;

        // Four Booth iterations
        for (i = 0; i < 4; i = i + 1) begin

            // Booth operation
            case ({Q_reg[0], Q_minus1})

                2'b01: A = A + M_ext;
                2'b10: A = A - M_ext;
                2'b00: A = A;
                2'b11: A = A;

            endcase

            // Arithmetic right shift
            Q_minus1 = Q_reg[0];
            Q_reg = {A[0], Q_reg[3:1]};
            A = {A[4], A[4:1]};

        end

        // Final product
        Product = {A[3:0], Q_reg};

    end

endmodule