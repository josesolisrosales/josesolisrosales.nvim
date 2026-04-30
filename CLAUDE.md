# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim) with a modular plugin structure. It targets Lua-based configuration with support for multiple languages (Python, TypeScript/JavaScript, Go, Lua, Terraform/HCL, C/C++).

## Architecture

- **`init.lua`**: Entry point. Sets leader key, vim options, core keymaps, bootstraps lazy.nvim, and defines the global `TermToggle()` function.
- **`lua/custom/plugins/`**: Each `.lua` file in this directory is auto-imported by lazy.nvim and returns a plugin spec table. Add new plugins by creating a new file here.
- **`lazy-lock.json`**: Lock file pinning plugin commits — update with `:Lazy update` inside Neovim.

## Plugin File Conventions

Each file in `lua/custom/plugins/` follows this pattern:

```lua
return {
  "author/plugin-name",
  dependencies = { ... },
  config = function()
    require("plugin").setup({ ... })
  end,
}
```

Keymaps for a plugin are typically defined inside its `config` function or via the `keys` table in the spec.

## Key Plugins and Their Files

| File | Purpose |
|------|---------|
| `lsp.lua` | LSP servers (pyright, ts_ls, lua_ls, tflint, helm_ls) via Mason |
| `blink-cmp.lua` | Completion engine; integrates LSP, snippets, and Copilot |
| `conform.lua` | Format-on-save (stylua, black, prettier, gofmt, terraform_fmt) |
| `lint.lua` | Auto-linting on save (pylint, eslint, golangci-lint, markdownlint, tflint) |
| `telescope.lua` | Fuzzy finder with FZF native extension |
| `treesitter.lua` | Syntax highlighting and text objects |
| `neotree.lua` | File explorer |
| `git.lua` | Fugitive + Gitsigns |
| `material-theme.lua` | Colorscheme ("oceanic" style) |
| `enhanced-todo.lua` | Todo comment tracking and navigation |
| `autosave.lua` | Auto-save on InsertLeave/TextChanged |

## Adding a New LSP Server

1. Add the server name to `ensure_installed` in `lua/custom/plugins/lsp.lua` under `mason-tool-installer`.
2. Add a server config entry in the `servers` table in the same file.
3. Run `:MasonToolsInstall` inside Neovim to install it.

## Adding a New Formatter or Linter

- **Formatters**: Edit `lua/custom/plugins/conform.lua`, add to `formatters_by_ft`.
- **Linters**: Edit `lua/custom/plugins/lint.lua`, add to `linters_by_ft`.

## Nerd Font

The `vim.g.have_nerd_font = true` flag in `init.lua` controls icon rendering across plugins. Toggle to `false` if the terminal doesn't have a Nerd Font installed.

## Tool Management

[mise](https://mise.jdx.dev/) is used for runtime version management. The shim directory (`~/.local/share/mise/shims`) is prepended to `PATH` at startup so LSP servers and formatters installed via mise are available inside Neovim.
