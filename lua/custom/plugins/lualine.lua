-- Lualine statusline
return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			icons_enabled = vim.g.have_nerd_font,
			theme = "everforest",
			component_separators = "|",
			section_separators = "",
		},
	},
}
