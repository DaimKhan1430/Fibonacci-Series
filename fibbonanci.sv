module fibonacci_gen #(
    parameter WIDTH = 64
)(
    input  logic clk,
    input  logic reset,
    input  logic start,
    input  logic [31:0] N_value,
    output logic done,
    output logic [WIDTH-1:0] fib_out
);

    logic [WIDTH-1:0] a, b;
    integer count;

    always_ff @(posedge clk) begin
        if (reset) begin
            a <= 0;
            b <= 1;
            count <= 0;
            done <= 0;
            fib_out <= 0;
        end
        else if (start && !done) begin
            if (count == 0) begin
                fib_out <= 0;
                count <= count + 1;
            end
            else if (count == 1) begin
                fib_out <= 1;
                count <= count + 1;
            end
            else if (count < N_value) begin
                fib_out <= a + b;
                a <= b;
                b <= a + b;
                count <= count + 1;
            end
            else begin
                done <= 1;
            end
        end
    end
endmodule