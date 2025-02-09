-------------------------------------------------------------------------------
-- Options
-------------------------------------------------------------------------------

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set nohlsearch")
vim.cmd("set ignorecase")
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opts = { silent = true }
vim.keymap.set("n", "<Tab>",   ">>",  opts)
vim.keymap.set("n", "<S-Tab>", "<<",  opts)
vim.keymap.set("v", "<Tab>",   ">>", opts)
vim.keymap.set("v", "<S-Tab>", "<<", opts)
vim.keymap.set('n', '<C-i>', '<C-i>') -- Distinguish <Tab> from <C-i> in normal mode

-- Fix heex/eex format
vim.filetype.add({
    extension = {
        heex = "eelixir",
        eex = "eelixir",
        leex = "eelixir",
        sface = "eelixir",
        lexs = "eelixir",
    }
})

-- Fix SASS/SCSS
vim.cmd("autocmd FileType scss setl iskeyword+=@")
vim.cmd("autocmd FileType scss setl iskeyword+=$")
vim.cmd("autocmd FileType scss setl iskeyword+=-")
vim.cmd("autocmd FileType scss setl iskeyword+=@")
vim.cmd("autocmd FileType scss setl iskeyword+=$")
vim.cmd("autocmd FileType scss setl iskeyword+=-")

-------------------------------------------------------------------------------
-- Global keymap
-------------------------------------------------------------------------------
vim.g.mapleader = " "
-------------------------------------------------------------------------------
-- Bootstrap Package Manager
-------------------------------------------------------------------------------

local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------

require('pckr').add{
    {
    'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    },
    {
        "kepano/flexoki-neovim",
        name = 'flexoki',
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "flexoki-dark"
        end
    },
    { 'nvim-tree/nvim-web-devicons' },
    { "ibhagwan/fzf-lua" },
    { 'nvim-lua/plenary.nvim' },
    { 'elixir-editors/vim-elixir' },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        requres = {'nvim-lua/plenary.nvim'},
    },
    {
        'echasnovski/mini.nvim',
        version = false ,
        config = function()
            require('mini.surround').setup()
            require('mini.indentscope').setup()
        end
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    {
        'neoclide/coc.nvim',
        branch  = 'release'
    },
    {
        "neovim/nvim-lspconfig"
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requres = { {"nvim-lua/plenary.nvim"} }
    },
    {   "nvim-tree/nvim-tree.lua"  }
}

------------------------------------------------------------------------
-- Local keymap
------------------------------------------------------------------------

-- FZF
vim.keymap.set("n", "<c-z>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })

-- Telescope
local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<c-f>", builtin.live_grep, {})

------------------------------------------------------------------------
-- CocNvim
------------------------------------------------------------------------

local keyset = vim.keymap.set

-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
-- Use <c-space> to trigger completion
    keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
    keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
    keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
    keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
    keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
    keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
    keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
    keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
    keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
    keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    -- elseif vim.api.nvim_eval('coc#rpc#ready()') then
    --     vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
    keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

-- Formatting selected code
    keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
    keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

-- Remap to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-i>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-i>"', opts)
keyset("n", "<C-S-i>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-S-i>"', opts)
keyset("i", "<C-i>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-S-i>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-i>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-i>"', opts)
keyset("v", "<C-S-i>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-S-i>"', opts)

---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics
    keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
    keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
    keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)

-------------------------------------------------------------------------------
-- Harpoon2
-------------------------------------------------------------------------------

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>z", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>q", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-h>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-l>", function() harpoon:list():next() end)

-- nvim-tree
vim.keymap.set("n", "<C-s>", "<cmd>NvimTreeToggle<CR>")

-- pass to setup along with your other options
require("nvim-tree").setup {
  ---
  on_attach = my_on_attach,
  ---
}

