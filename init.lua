-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Make line numbers default
vim.o.number = true
-- Line relative number to jump up and down quickly
vim.o.relativenumber = true

-- Enable mouse mode, useful for resizing splits
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 20

-- Confirm before closing unsaved buffers
vim.o.confirm = true

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Default indentation settings (for new files before vim-sleuth detects)
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.softtabstop = 2

-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
-- See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

-- Exit terminal mode in the builtin terminal with a shortcut
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Copilot keymaps
vim.keymap.set("n", "<leader>cp", ":Copilot panel<CR>", { desc = "[C]opilot [P]anel" })
vim.keymap.set("n", "<leader>cs", ":Copilot status<CR>", { desc = "[C]opilot [S]tatus" })
vim.keymap.set("n", "<leader>ce", ":Copilot enable<CR>", { desc = "[C]opilot [E]nable" })
vim.keymap.set("n", "<leader>cd", ":Copilot disable<CR>", { desc = "[C]opilot [D]isable" })

-- Toggle copilot suggestions
vim.keymap.set("n", "<leader>ct", function()
	if require("copilot.suggestion").is_visible() then
		require("copilot.suggestion").dismiss()
	else
		require("copilot.suggestion").next()
	end
end, { desc = "[C]opilot [T]oggle" })

-- [[ Basic Autocommands ]]
-- See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
-- See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({
	-- Import custom plugins
	{ import = "custom.plugins" },
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- [[ VSCode-like Terminal Function ]]
-- Your custom terminal toggle function
local term_buf = nil
local term_win = nil

function TermToggle(height)
	-- Check if terminal window is valid and visible
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		if vim.api.nvim_get_current_win() == term_win then
			-- Close the terminal if it already exists
			vim.api.nvim_win_close(term_win, true)
			term_win = nil
			return
		else
			vim.api.nvim_set_current_win(term_win)
			return
		end
	end

	-- Terminal Window Creation
	vim.cmd("botright new")
	vim.api.nvim_win_set_height(0, height)

	-- Buffer Handling
	if term_buf and vim.api.nvim_buf_is_loaded(term_buf) then
		vim.api.nvim_win_set_buf(0, term_buf)
	else
		term_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_win_set_buf(0, term_buf)
		local shell = vim.o.shell -- Get default shell
		vim.fn.termopen(shell, {
			on_exit = function()
				term_win = nil
			end,
		})
		term_win = vim.api.nvim_get_current_win()
		vim.api.nvim_buf_set_option(term_buf, "buflisted", false)
		vim.api.nvim_win_set_option(0, "number", false)
		vim.api.nvim_win_set_option(0, "relativenumber", false)
		vim.api.nvim_win_set_option(0, "signcolumn", "no")
	end
	-- Enter Insert Mode by default
	vim.cmd("startinsert!")
	term_win = vim.api.nvim_get_current_win()
end

-- Terminal keymaps
vim.api.nvim_set_keymap(
	"n",
	"<C-`>",
	":lua TermToggle(12)<cr>",
	{ noremap = true, silent = true, desc = "Toggle Terminal" }
)
vim.api.nvim_set_keymap(
	"t",
	"<C-`>",
	"<C-\\><C-n>:lua TermToggle(12)<cr>",
	{ noremap = true, silent = true, desc = "Toggle Terminal" }
)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
