`timescale 1ns / 1ps

module tb_fibonacci;

    logic clk;
    logic reset;
    logic start;
    logic done;
    logic [63:0] fib_out;
    logic [31:0] N_value;

    fibonacci_gen #(
        .WIDTH(64)
    ) dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .N_value(N_value),
        .done(done),
        .fib_out(fib_out)
    );

    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        reset = 1;
        start = 0;
        N_value = 1;
        #10;
        reset = 0;
        start = 1;
        N_value = 1000;
        wait(done);
        $display("Completed %0d Fibonacci iterations.", N_value);
        #2000;
        $finish;
    end

    always @(posedge clk) begin
        if (start && !done)
            $display("Fib[%0d] = %0d", dut.count, fib_out);
    end

endmodule