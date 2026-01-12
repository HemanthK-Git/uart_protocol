`timescale 1ns / 1ps

module baud_rate_generator #(
  parameter system_clk = 50_000_000, // 50 Mhz
  parameter baud_rate = 9600 // 9600 bps
  
)(
  input logic clk,
  input logic rst,
  input logic enable,
  output logic baud_tick 
);
  
  localparam int divider = system_clk / baud_rate;
  
  localparam int bits = $clog2(divider);
  
  logic [bits - 1 : 0] counter;
  
  always @(posedge clk or negedge rst) begin
    if(!rst) begin
      counter <= 0;
      baud_tick <= 0;      
    end
    else if (enable) begin
    if (counter == (divider - 1)) begin
      counter <= 0;
      baud_tick <= 1'b1;
    end
    else begin
      counter <= counter + 1;
      baud_tick <= 0;
    end    
    end
  end
endmodule
