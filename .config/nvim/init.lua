-- Leader / 领导键
vim.g.mapleader = " "
-- Coc extensions auto install / 自动安装扩展
vim.g.coc_global_extensions = {
  "coc-pyright",
  "coc-sh",
}

-- vim-plug bootstrap / 插件管理引导
if vim.fn.empty(vim.fn.glob(vim.fn.expand("~/.config/nvim/autoload/plug.vim"))) > 0 then
  vim.fn.system({
    "curl",
    "-fLo",
    vim.fn.expand("~/.config/nvim/autoload/plug.vim"),
    "--create-dirs",
    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
  })
  vim.cmd("autocmd VimEnter * PlugInstall --sync | source $MYVIMRC")
end

-- vim-plug plugin list / 插件列表
vim.cmd([[
  call plug#begin('~/.config/nvim/plugged')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  call plug#end()
]])

-- coc.nvim official example mappings / 官方示例按键
vim.cmd([[
  " coc.nvim official example mappings
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()

  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " CheckBackspace: decide Tab for indent vs completion
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gr <Plug>(coc-references)
  nnoremap <silent> <leader>d :CocList diagnostics<CR>
  nmap <silent> [d <Plug>(coc-diagnostic-prev)
  nmap <silent> ]d <Plug>(coc-diagnostic-next)
  nmap <leader>a <Plug>(coc-codeaction)
  xmap <leader>a <Plug>(coc-codeaction-selected)
  nnoremap <silent> <leader>h :call CocAction('doHover')<CR>
  nnoremap <silent> <leader>f :CocCommand editor.action.formatDocument<CR>
  nnoremap <silent> <leader>s :CocList symbols<CR>
  nmap <silent> <leader>r <Plug>(coc-rename)
]] )

-- Basic keymaps / 基础按键
vim.keymap.set("", "s", "<nop>")
vim.keymap.set("n", "S", ":w<CR>")
vim.keymap.set("n", "Q", ":q<CR>")

vim.keymap.set("n", "J", "5j")
vim.keymap.set("n", "K", "5k")
vim.keymap.set("n", "H", "8H")
vim.keymap.set("n", "L", "8L")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<LEADER>/", ":nohlsearch<CR>")

-- Split/window management / 分屏与窗口
vim.keymap.set("n", "sk", ":set nosplitbelow<CR>:split<CR>")
vim.keymap.set("n", "sj", ":set splitbelow<CR>:split<CR>")
vim.keymap.set("n", "sh", ":set nosplitright<CR>:vsplit<CR>")
vim.keymap.set("n", "sl", ":set splitright<CR>:vsplit<CR>")

vim.keymap.set("n", "<up>", ":res +5<CR>")
vim.keymap.set("n", "<down>", ":res -5<CR>")
vim.keymap.set("n", "<left>", ":vertical resize -5<CR>")
vim.keymap.set("n", "<right>", ":vertical resize +5<CR>")

vim.keymap.set("n", "<LEADER>l", "<C-w>l")
vim.keymap.set("n", "<LEADER>k", "<C-w>k")
vim.keymap.set("n", "<LEADER>j", "<C-w>j")
vim.keymap.set("n", "<LEADER>h", "<C-w>h")

vim.keymap.set("n", "<LEADER>L", "<C-w>t<C-w>L")
vim.keymap.set("n", "<LEADER>K", "<C-w>t<C-w>K")
vim.keymap.set("n", "<LEADER>J", "<C-w>t<C-w>J")
vim.keymap.set("n", "<LEADER>H", "<C-w>t<C-w>H")

-- Editor options / 编辑器选项
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmenu = true

-- Search behavior / 搜索行为
vim.cmd("syntax on")
vim.cmd("nohlsearch")
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard="unnamedplus"
vim.o.inccommand="nosplit"

-- UI styling / 外观设置
vim.cmd("colorscheme habamax")
vim.cmd("hi Normal guifg=#E6E6E6")
--vim.cmd([[
--	hi Comment gui=italic
--	hi Visual guibg=#444444
--]])
-- Transparent terminal / 透明终端
vim.opt.termguicolors=true
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
