-- Lualine statusline
return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			icons_enabled = vim.g.have_nerd_font,
			theme = "material",
			component_separators = "|",
			section_separators = "",
		},
	},
}
