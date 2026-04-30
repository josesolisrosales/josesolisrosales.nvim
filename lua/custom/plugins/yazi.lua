return {
	"mikavilpas/yazi.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>y",
			"<cmd>Yazi<cr>",
			desc = "Open [Y]azi at current file",
		},
		{
			"<leader>Y",
			"<cmd>Yazi cwd<cr>",
			desc = "Open [Y]azi in working directory",
		},
	},
	opts = {},
}
