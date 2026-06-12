return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	ft = { "markdown" },
	keys = {
		{
			"<leader>tm",
			"<cmd>RenderMarkdown toggle<cr>",
			desc = "[T]oggle [M]arkdown rendering",
		},
	},
	opts = {},
}
