# Neovim Config

Minimal Neovim config with vim-plug + coc.nvim, tuned for Python and Bash.

## Requirements
- Neovim
- curl
- Node.js + npm (required by coc.nvim)

Optional tools:
- shellcheck (Bash diagnostics, used by coc-sh)


vim-plug bootstraps automatically and runs PlugInstall on first launch.

## Coc Extensions (auto-installed)
- coc-pyright (Python LSP)
- coc-sh (Bash LSP)

## Format On Save
Not enabled by default in this repo. If you want format-on-save, configure it in
`coc-settings.json` and install the formatters you choose.

## Key Coc Mappings
- `Tab` / `Shift-Tab` / `Enter`: completion navigation and confirm
- `gd` / `gD` / `gi` / `gy` / `gr`: definition, tab definition, implementation, type, references
- `<leader>r`: rename
- `<leader>d`: diagnostics list
- `[d` / `]d`: prev/next diagnostic
- `<leader>a`: code actions (normal/visual)
- `<leader>h`: hover docs
- `<leader>f`: format document
- `<leader>s`: symbols list

## Files
- `init.lua`: main Neovim config
- `coc-settings.json`: coc.nvim settings
- `.gitignore`: ignores downloaded plugins and coc caches

## Troubleshooting
- `:CocInfo` shows coc status
- `:CocList extensions` shows installed extensions
- `:CocDiagnostics` shows diagnostics
