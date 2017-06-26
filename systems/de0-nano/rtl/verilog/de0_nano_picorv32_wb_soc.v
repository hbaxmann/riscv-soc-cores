module de0_nano_picorv32_wb_soc(
	input  CLOCK_50,
	inout  [33:0] GPIO_0,
	inout  [33:0] GPIO_1
	);

	wire wb_clk;
	wire wb_rst;

	altpll_clkgen #(
		.DEVICE_FAMILY ("Cyclone IV E"),
		.INPUT_FREQUENCY (50),
		.DIVIDE_BY (25),
		.MULTIPLY_BY (12)
	)
	clkgen(
		.sys_clk_pad_i(CLOCK_50),
		.rst_n_pad_i(1),
		.wb_clk_o(wb_clk),
		.wb_rst_o(wb_rst)
	);

	picorv32_wb_soc #(
		.BOOTROM_MEMFILE ("../src/riscv-nmon_0/nmon_picorv32-wb-soc_24MHz_115200.txt"),
		.BOOTROM_MEMDEPTH (1024),
		.SRAM0_MEMDEPTH (32768)
	)
	soc(
		.clock(wb_clk),
		.reset(wb_rst),
		.wb_iadr_o(),
		.uart_rx(GPIO_0[32]),
		.uart_tx(GPIO_0[33])
	);

endmodule
