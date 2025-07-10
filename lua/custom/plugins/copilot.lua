-- GitHub Copilot integration
return {
	-- Copilot.lua (main plugin)
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			panel = {
				enabled = false,
			},
			suggestion = {
				enabled = false,
			},
			copilot_node_command = "node", -- Node.js version must be > 18.x
			server_opts_overrides = {},
		},
	},

	-- Copilot integration for blink.cmp
	"giuxtaposition/blink-cmp-copilot",
}
