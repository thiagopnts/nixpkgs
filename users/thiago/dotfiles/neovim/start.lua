-- initialize and setup plugin manager
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end
vim.api.nvim_exec(
	[[
  augroup Packer
    autocmd!
    autocmd BufWritePost start.lua PackerCompile
  augroup end
]],
	false
)

vim.api.nvim_exec(
	[[
  autocmd! VimEnter * nested NvimTreeClose
]],
	true
)

-- prepare to define plugins
local use = require("packer").use
require("packer").startup(function()
	-- Package manager itself
	use("wbthomason/packer.nvim")
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	})
	use("github/copilot.vim")
	use("ray-x/lsp_signature.nvim") -- show function signature when you type
	use("cespare/vim-toml") -- toml syntax highlight
	use("axelf4/vim-strip-trailing-whitespace") -- remove trailing whitespace
	use("kyazdani42/nvim-web-devicons") -- for file icons
	use("tpope/vim-fugitive")
	use("christoomey/vim-tmux-navigator")
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("folke/lsp-colors.nvim") -- this creates missing LSP diagnostics highlight groups(e.g. my jellybeans colorscheme :D)
	use("jose-elias-alvarez/null-ls.nvim")
	--	use("HallerPatrick/py_lsp.nvim")
	--	use({
	--		"mattn/emmet-vim", -- rust lang support
	--		config = function()
	--			vim.g.user_emmet_install_global = 0
	--			vim.g.user_emmet_leader_key = "<TAB>"
	--			vim.api.nvim_exec(
	--				[[
	--		      FileType html,css EmmetInstall
	--		    ]],
	--				false
	--			)
	--		end,
	--	})
	use({
		"folke/trouble.nvim", -- rust lang support
		config = function()
			require("trouble").setup({})
		end,
	})
	-- jellybeans colorscheme and its dependency lush
	use("rktjmp/lush.nvim")
	use("~/src/jellybeans")
	use("tpope/vim-repeat") -- repeat unrepeatable commands
	use("andweeb/presence.nvim")
	use("hashivim/vim-terraform")
	use("tpope/vim-surround") -- classic surround plugin
	use("TovarishFin/vim-solidity")
	-- lsp cmp stuff
	use("neovim/nvim-lspconfig") -- client for language servers
	use("hrsh7th/cmp-nvim-lsp")
	use("jamestthompson3/nvim-remote-containers")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip") -- snippets
	use("hrsh7th/nvim-cmp") -- auto completion plugin
	use("phaazon/hop.nvim")
	use("LnL7/vim-nix") -- nix syntax support
	use("simrat39/rust-tools.nvim") -- extra rust functionality(e.g. inlay hints etc)
	use({
		"APZelos/blamer.nvim", -- show commit/blame current line
		config = function()
			vim.g.blamer_enabled = 1
		end,
	})
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({ options = { theme = "jellybeans" } })
		end,
	})
	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("glepnir/lspsaga.nvim")
	use({
		"bkad/CamelCaseMotion", -- can jump between camel|snakecase words
		config = function()
			vim.g.camelcasemotion_key = ","
		end,
	})
	use({
		"onsails/lspkind-nvim",
	})
	-- auto close pairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	-- vim-go like
	-- commented out to try ray-x/go.nvim
	--	use({
	--		"crispgm/nvim-go",
	--		config = function()
	--			require("go").setup({ auto_lint = false })
	--		end,
	--	})
	use({
		"ray-x/go.nvim",
		config = function()
			require("go").setup({ auto_lint = false })
		end,
	})

	use({
		"lewis6991/gitsigns.nvim", -- git.... signs
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { hl = "DiffAdd", text = "???", numhl = "GitSignsAddNr" },
					change = { hl = "DiffChange", text = "???", numhl = "GitSignsChangeNr" },
					delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
					topdelete = { hl = "DiffDelete", text = "???", numhl = "GitSignsDeleteNr" },
					changedelete = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
				},

				numhl = false,
				keymaps = {
					-- Default keymap options
					noremap = true,
					buffer = true,
					["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
					["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
					["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
					["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
					["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
					["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
					["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>',
				},
				watch_gitdir = {
					interval = 100,
				},
				sign_priority = 5,
				status_formatter = nil, -- Use default
			})
		end,
	})
	use({
		"akinsho/nvim-bufferline.lua", -- top tabs bar
		config = function()
			require("bufferline").setup({
				options = {
					offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
					buffer_close_icon = "??",
					--            modified_icon = "???",
					close_icon = "??",
					--            left_trunc_marker = "???",
					--            right_trunc_marker = "???",
					max_name_length = 14,
					max_prefix_length = 13,
					tab_size = 20,
					show_tab_indicators = true,
					enforce_regular_tabs = false,
					view = "multiwindow",
					show_buffer_close_icons = true,
					separator_style = "thin",
					--mappings = "true"
				},
			})
		end,
	})
	--	use({
	--		"andweeb/presence.nvim",
	--		config = function()
	--			--        require("presence"):setup {
	--			--          editing_text = "Coding %s",
	--			--        }
	--		end,
	--	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.opt.list = true
			vim.opt.listchars:append("eol:???")
			vim.g.indentLine_enabled = 1
			--        vim.g.indent_blankline_char = "???"
			vim.g.indent_blankline_char = "???"
			vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
			vim.g.indent_blankline_buftype_exclude = { "terminal" }
			vim.g.indent_blankline_show_trailing_blankline_indent = false
			vim.g.indent_blankline_show_first_indent_level = false
			require("indent_blankline").setup({
				show_current_context = true,
			})
		end,
	})
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			vim.g.nvim_tree_side = "left"
			vim.g.nvim_tree_width = 25
			vim.g.nvim_tree_git_hl = 1
			vim.g.nvim_tree_root_folder_modifier = ":t"
			vim.g.nvim_tree_allow_resize = 1
			--			vim.g.nvim_tree_icons = {
			--				default = "??? ",
			--				symlink = "????",
			--				folder = {
			--					default = "????",
			--					open = "????",
			--					symlink = "????",
			--					empty = "????",
			--					empty_open = "????",
			--					symlink_open = "????",
			--				},
			--			}
			require("nvim-tree").setup({
				open_on_setup = false,
				auto_close = false,
				open_on_tab = false,
				indent_markers = true,
				disable_window_picker = true,
				quit_on_open = true,
				update_focused_file = { enable = false },
				git = {
					enable = false,
					auto_open = false,
				},
				filters = {
					dotfiles = true,
					custom = { ".git", "node_modules", ".cache" },
				},
			})
		end,
	})
	use({ "nvim-telescope/telescope-fzy-native.nvim", run = "make" })
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		config = function()
			require("telescope").setup({
				extensions = {
					fzy_native = {
						override_generic_sorter = false,
						override_file_sorter = true,
					},
				},
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					prompt_prefix = "> ",
					selection_caret = "> ",
					entry_prefix = "  ",
					initial_mode = "insert",
					selection_strategy = "reset",
					sorting_strategy = "descending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							mirror = false,
						},
						vertical = {
							mirror = false,
						},
					},
					file_sorter = require("telescope.sorters").get_fuzzy_file,
					file_ignore_patterns = {},
					generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
					winblend = 0,
					border = {},
					borderchars = { "???", "???", "???", "???", "???", "???", "???", "???" },
					color_devicons = true,
					use_less = true,
					path_display = {},
					set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					-- Developer configurations: Not meant for general override
					buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				},
				pickers = {
					find_files = {
						theme = "dropdown",
					},
					live_grep = {
						theme = "dropdown",
					},
				},
			})
			require("telescope").load_extension("fzy_native")
		end,
	})
end)
vim.api.nvim_command("colorscheme jellybeans")

local lspkind = require("lspkind")

local cmp = require("cmp")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
})

local signs = { Error = "???", Warn = "???", Hint = "??? ", Info = "??? " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local saga = require("lspsaga")
saga.init_lsp_saga({
	error_sign = "???",
	warn_sign = "???",
	hint_sign = "??? ",
	infor_sign = "??? ",
	rename_prompt_prefix = "",
})

local rust_tools_opts = {
	tools = { -- rust-tools options
		autoSetHints = true,
		hover_with_actions = false,
		inlay_hints = {
			show_parameter_hints = true,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},

	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
	server = {
		-- on_attach is a callback called when the language server attachs to the buffer
		-- on_attach = on_attach,
		settings = {
			-- to enable rust-analyzer settings visit:
			-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
			["rust-analyzer"] = {
				-- enable clippy on save
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
}

require("rust-tools").setup(rust_tools_opts)
--require("py_lsp").setup()

require("hop").setup()

require("opts")
require("_mappings")
require("_lspconfig")
