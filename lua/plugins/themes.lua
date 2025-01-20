return {
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load()
		end,
	},
	{ "NLKNguyen/papercolor-theme", name = "PaperColor" },
	{ "sainnhe/sonokai", name = "sonokai" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "rose-pine/neovim", name = "rose-pine" },
  {'rmehri01/onenord.nvim', name = "onenord"},
	{ "sainnhe/edge", name = "edge" },
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
}
