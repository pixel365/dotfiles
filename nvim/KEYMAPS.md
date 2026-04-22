# Keymaps

Leader: `Space`

## Navigation

- `<Space><Space>` — Find files
- `<Space>/` — Live grep in project
- `<Space>b` — Open buffers
- `<Space>.` — Recent files
- `<Space>,` — Resume last `fzf-lua` picker
- `<Space>ss` — Symbols in current file
- `<Space>sS` — Symbols in workspace
- `<Space>e` — Toggle file tree
- `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` — Move between windows
- `<Space>v` — Vertical split
- `<Space>s` — Horizontal split

## Terminal

- `<Space>t` — Toggle terminal split
- `<Esc>` — Leave terminal mode
- `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` — Move between windows from terminal mode

## LSP

- `gd` — Go to definition
- `gr` — Find references / usages
- `K` — Hover documentation
- `<Space>rn` — Rename symbol
- `<Space>ca` — Code action
- `<Space>fo` — Format buffer
- `<Space>ds` — Show diagnostics under cursor
- `[d` / `]d` — Previous / next diagnostic
- `<Space>xx` — Workspace diagnostics

## Git

- `]h` / `[h` — Next / previous git hunk
- `<Space>hp` — Preview hunk
- `<Space>hs` — Stage hunk
- `<Space>hr` — Reset hunk
- `<Space>gb` — Toggle git blame view for the current file

## Editing

- `<A-d>` — Duplicate current line below
- `<A-j>` / `<A-k>` — Move current line down / up
- Visual `<A-j>` / `<A-k>` — Move selected block down / up

## Selection

- `v` — Characterwise visual mode
- `V` — Linewise visual mode
- `<C-v>` — Block visual mode
- `viw` / `vaw` — Select inner word / word with surrounding space
- `vip` / `vap` — Select inner paragraph / paragraph
- `vi(` / `va(` — Select inside parentheses / around parentheses
- `vi{` / `va{` — Select inside braces / around braces
- `vi[` / `va[` — Select inside brackets / around brackets
- `vi"` / `va"` — Select inside double quotes / around double quotes
- `vi'` / `va'` — Select inside single quotes / around single quotes
- `vit` / `vat` — Select inside HTML/XML tag / around tag
- `vaf` / `vif` — Select outer / inner function
- `vac` / `vic` — Select outer / inner class or struct

## Small Built-ins

- `r<char>` — Replace the character under cursor
- `x` — Delete the character under cursor
- `s` — Delete character and enter insert mode
- `cw` — Change from cursor to end of word
- `ciw` — Change inner word
- `C` — Change to end of line
