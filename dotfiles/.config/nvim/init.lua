-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packa/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvm
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'kabouzeid/nvim-lspinstall'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'wakatime/vim-wakatime'
  use 'ayu-theme/ayu-vim'
  use 'fenetikm/falcon'
  use 'norcalli/nvim-colorizer.lua'
  use 'airblade/vim-rooter'
  use 'mattn/emmet-vim'
  -- use {'nvim-telescope/telescope.nvim',  requires = {  {'nvim-lua/plenary.nvim'},  {"nvim-telescope/telescope-fzf-native.nvim",run = "make"} }}
  use {'kyazdani42/nvim-tree.lua',requires = 'kyazdani42/nvim-web-devicons'}
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'p00f/nvim-ts-rainbow'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'romgrk/nvim-treesitter-context'
  use 'romgrk/barbar.nvim'
 use {'famiu/feline.nvim',requires = { {'lewis6991/gitsigns.nvim',requires = { 'nvim-lua/plenary.nvim' },config = function()require('gitsigns').setup()end},'kyazdani42/nvim-web-devicons'}}end)
use {
    's1n7ax/nvim-terminal',
    config = function()
        vim.o.hidden = true
        require('nvim-terminal').setup()
    end,
}
use {'liuchengxu/vim-clap', run=':CLap install-binary!'  }
---- SETTINGS -------
---------------------

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = false
--Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = false

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 100
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.cmd [[colorscheme falcon]]

--Set statusbar
vim.g.lightline = {
  colorscheme = 'onedark',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}
--Remap for dealing with word wrap
-- vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", opts)
-- vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", opts)

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
-- require('telescope').setup {
--   defaults = {
--     mappings = {
--       i = {
--         ['<C-u>'] = false,
--         ['<C-d>'] = false,
--       },
--     },
--   },
-- }
-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    ensure_installed = {"html","javascript","lua","css","fish","json","php","rust","tsx","typescript","vue","c"},
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- LSP settings
local nvim_lsp = require 'lspconfig'


-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
local sumneko_root_path = vim.fn.getenv 'HOME' .. '/.local/bin/sumneko_lua' -- Change to your sumneko root installation
local sumneko_binary = sumneko_root_path .. '/bin/linux/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}






---------------------------
--------MAPPINGS ----------
---------------------------

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
--
--Add leader shortcuts
map('n', '<leader><space>', ':Clap buffers<CR>', opts)
map('n', '<leader>ff', ':Clap files<CR>', opts)
map('n', '<leader>fs', ':Clap grep<CR>', opts)
map('n', '<leader>ll', ':Clap blines<CR>', opts)
map('n', '<leader>fc', ':Clap filer<CR>', opts)
map('n', '<leader>oo', ':Clap recent_files<CR>', opts)

map('n', '<TAB>', ':BufferPrevious<CR>', opts)
map('n', '<S-TAB>', ':BufferNext<CR>', opts) map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
map('n', '<A-0>', ':BufferLast<CR>', opts)
map('n', '<A-c>', ':BufferClose<CR>', opts)
map('n', '<A-e>', ':NvimTreeToggle<CR>', opts)

local on_attach = function(_, bufnr)
  map(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  map(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  map(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  map(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  map(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  map(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  map(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  map(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  map(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end


map('n', '<leader>t', ':lua NTGlobal["terminal"]:toggle()<CR>', opts)
map('n', '<leader>1', ':lua NTGlobal["terminal"]:open(1)<CR>', opts)
map('n', '<leader>2', ':lua NTGlobal["terminal"]:open(2)<CR>', opts)
map('n', '<leader>3', ':lua NTGlobal["terminal"]:open(3)<CR>', opts)
map('n', '<leader>4', ':lua NTGlobal["terminal"]:open(4)<CR>', opts)
map('n', '<leader>5', ':lua NTGlobal["terminal"]:open(5)<CR>', opts)
map('n', '<leader>6', ':lua NTGlobal["terminal"]:open(6)<CR>', opts)
map('n', '<leader>+', ':lua NTGlobal["window"]:change_height(2)<CR>', opts)
map('n', '<leader>-', ':lua NTGlobal["window"]:change_height(-2)<CR>', opts)

-----------------------
------ BARBAR ---------
-----------------------

vim.g.bufferline = {
  animation = true,
  auto_hide = false,
  tabpages = true,
  closable = true,
  clickable = true,
  icons = true,
  icon_custom_colors = false,
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',
  insert_at_end = false,
  maximum_padding = 1,
  maximum_length = 30,
  semantic_letters = true,
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
  no_name_title = nil,
}


-------------------
-----FELINE--------
 local lsp = require('feline.providers.lsp')
 local vi_mode_utils = require('feline.providers.vi_mode')

 local force_inactive = {
     filetypes = {},
     buftypes = {},
     bufnames = {}
 }

 local components = {
   active = {{}, {}, {}},
   inactive = {{}, {}, {}},
 }

 local colors = {
   bg = '#060608',
   black = '#060608',
   yellow = '#ffb52a',
   cyan = '#89b482',
   oceanblue = '#00a9a5',
   green = '#5b8642',
   orange = '#e78a4e',
   violet = '#7d80da',
   magenta = '#d85a6b',
   white = '#fff',
   fg = '#f5f5ff',
   skyblue = '#74b3d2',
   red = '#bd2c40',
 }

 local vi_mode_colors = {
   NORMAL = 'green',
   OP = 'green',
   INSERT = 'red',
   VISUAL = 'skyblue',
   BLOCK = 'skyblue',
   REPLACE = 'violet',
   ['V-REPLACE'] = 'violet',
   ENTER = 'cyan',
   MORE = 'cyan',
   SELECT = 'orange',
   COMMAND = 'green',
   SHELL = 'green',
   TERM = 'green',
   NONE = 'yellow'
 }

 local vi_mode_text = {
   NORMAL = '<|',
   OP = '<|',
   INSERT = '|>',
   VISUAL = '<>',
   BLOCK = '<>',
   REPLACE = '<>',
   ['V-REPLACE'] = '<>',
   ENTER = '<>',
   MORE = '<>',
   SELECT = '<>',
   COMMAND = '<|',
   SHELL = '<|',
   TERM = '<|',
   NONE = '<>'
 }

 local buffer_not_empty = function()
   if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
     return true
   end
   return false
 end

 local checkwidth = function()
   local squeeze_width  = vim.fn.winwidth(0) / 2
   if squeeze_width > 40 then
     return true
   end
   return false
 end

 force_inactive.filetypes = {
   'NvimTree',
   'dbui',
   'packer',
   'startify',
   'fugitive',
   'fugitiveblame'
 }

 force_inactive.buftypes = {
   'terminal'
 }

 -- LEFT

 -- vi-mode
 components.active[1][1] = {
   provider = ' NV-IDE ',
   hl = function()
     local val = {}

     val.bg = vi_mode_utils.get_mode_color()
     val.fg = 'black'
     val.style = 'bold'

     return val
   end,
   right_sep = ' '
 }
 -- vi-symbol
 components.active[1][2] = {
   provider = function()
     return vi_mode_text[vi_mode_utils.get_vim_mode()]
   end,
   hl = function()
     local val = {}
     val.fg = vi_mode_utils.get_mode_color()
     val.bg = 'bg'
     val.style = 'bold'
     return val
   end,
   right_sep = ' '
 }
 -- filename
 components.active[1][3] = {
   provider = function()
     return vim.fn.expand("%:F")
   end,
   hl = {
     fg = 'white',
     bg = 'bg',
     style = 'bold'
   },
   right_sep = ''
 }
 -- gitBranch
 components.active[1][4] = {
   provider = 'git_branch',
   hl = {
     fg = 'yellow',
     bg = 'bg',
     style = 'bold'
   }
 }
 -- diffAdd
 components.active[1][5] = {
   provider = 'git_diff_added',
   hl = {
     fg = 'green',
     bg = 'bg',
     style = 'bold'
   }
 }
 -- diffModfified
 components.active[1][6] = {
   provider = 'git_diff_changed',
   hl = {
     fg = 'orange',
     bg = 'bg',
     style = 'bold'
   }
 }
 -- diffRemove
 components.active[1][7] = {
   provider = 'git_diff_removed',
   hl = {
     fg = 'red',
     bg = 'bg',
     style = 'bold'
   }
 }

 -- MID

 -- LspName
 components.active[2][1] = {
   provider = 'lsp_client_names',
   hl = {
     fg = 'yellow',
     bg = 'bg',
     style = 'bold'
   },
   right_sep = ' '
 }
 -- diagnosticErrors
 components.active[2][2] = {
   provider = 'diagnostic_errors',
   enabled = function() return lsp.diagnostics_exist('Error') end,
   hl = {
     fg = 'red',
     style = 'bold'
   }
 }
 -- diagnosticWarn
 components.active[2][3] = {
   provider = 'diagnostic_warnings',
   enabled = function() return lsp.diagnostics_exist('Warning') end,
   hl = {
     fg = 'yellow',
     style = 'bold'
   }
 }
 -- diagnosticHint
 components.active[2][4] = {
   provider = 'diagnostic_hints',
   enabled = function() return lsp.diagnostics_exist('Hint') end,
   hl = {
     fg = 'cyan',
     style = 'bold'
   }
 }
 -- diagnosticInfo
 components.active[2][5] = {
   provider = 'diagnostic_info',
   enabled = function() return lsp.diagnostics_exist('Information') end,
   hl = {
     fg = 'skyblue',
     style = 'bold'
   }
 }

 -- RIGHT

 -- fileIcon
 components.active[3][1] = {
   provider = function()
     local filename = vim.fn.expand('%:t')
     local extension = vim.fn.expand('%:e')
     local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
     if icon == nil then
       icon = ''
     end
     return icon
   end,
   hl = function()
     local val = {}
     local filename = vim.fn.expand('%:t')
     local extension = vim.fn.expand('%:e')
     local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
     if icon ~= nil then
       val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
     else
       val.fg = 'white'
     end
     val.bg = 'bg'
     val.style = 'bold'
     return val
   end,
   right_sep = ' '
 }
 -- fileType
 components.active[3][2] = {
   provider = 'file_type',
   hl = function()
     local val = {}
     local filename = vim.fn.expand('%:t')
     local extension = vim.fn.expand('%:e')
     local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
     if icon ~= nil then
       val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
     else
       val.fg = 'white'
     end
     val.bg = 'bg'
     val.style = 'bold'
     return val
   end,
   right_sep = ' '
 }
 -- fileSize
 components.active[3][3] = {
   provider = 'file_size',
   enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
   hl = {
     fg = 'skyblue',
     bg = 'bg',
     style = 'bold'
   },
   right_sep = ' '
 }
 -- fileFormat
 components.active[3][4] = {
   provider = function() return '' .. vim.bo.fileformat:upper() .. '' end,
   hl = {
     fg = 'white',
     bg = 'bg',
     style = 'bold'
   },
   right_sep = ' '
 }
 -- fileEncode
 components.active[3][5] = {
   provider = 'file_encoding',
   hl = {
     fg = 'white',
     bg = 'bg',
     style = 'bold'
   },
   right_sep = ' '
 }
 --- lineInfo
 components.active[3][7] = {
   provider = 'position',
   hl = {
     fg = 'white',
     bg = 'bg',
     style = 'bold'
   },
   right_sep = ' '
 }
 -- linePercent
 components.active[3][8] = {
   provider = 'line_percentage',
   hl = {
     fg = 'white',
     bg = 'bg',
     style = 'bold'
   },
   right_sep = ' '
 }
 -- scrollBar
 components.active[3][9] = {
   provider = 'scroll_bar',
   hl = {
     fg = 'yellow',
     bg = 'bg',
   },
 }

 -- INACTIVE

 -- fileType
 components.inactive[1][1] = {
   provider = 'file_type',
   hl = {
     fg = 'black',
     bg = 'cyan',
     style = 'bold'
   },
   left_sep = {
     str = ' ',
     hl = {
       fg = 'NONE',
       bg = 'cyan'
     }
   },
   right_sep = {
     {
       str = ' ',
       hl = {
         fg = 'NONE',
         bg = 'cyan'
       }
     },
     ' '
   }
 }

 require('feline').setup({
   colors = colors,
   default_bg = bg,
   default_fg = fg,
   vi_mode_colors = vi_mode_colors,
   components = components,
   force_inactive = force_inactive,
 })
 -- require('feline').setup()


---------------------
-----COLORIZER-------
require 'colorizer'.setup {
  '*'; }
