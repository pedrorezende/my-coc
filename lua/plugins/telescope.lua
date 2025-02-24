-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
  tag = '0.1.8',
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
    {"fannheyward/telescope-coc.nvim"},

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		-- Telescope is a fuzzy finder that comes with a lot of different things that
		-- it can fuzzy find! It's more than just a "file finder", it can search
		-- many different aspects of Neovim, your workspace, LSP, and more!
		--
		-- The easiest way to use Telescope, is to start by doing something like:
		--  :Telescope help_tags
		--
		-- After running this command, a window will open up and you're able to
		-- type in the prompt window. You'll see a list of `help_tags` options and
		-- a corresponding preview of the help.
		--
		-- Two important keymaps to use while in Telescope are:
		--  - Insert mode: <c-/>
		--  - Normal mode: ?
		--
		-- This opens a window that shows you all of the keymaps for the current
		-- Telescope picker. This is really useful to discover what Telescope can
		-- do as well as how to actually do it!

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			-- defaults = {
			--   mappings = {
			--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			--   },
			-- },
			-- pickers = {}
			defaults = {
				file_ignore_patterns = { "node_modules" },
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "ignore_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        },
        coc = {
          prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
          push_cursor_on_edit = true, -- save the cursor position to jump back in the future
          timeout = 3000, -- timeout for coc commands
        }
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "coc")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set

		map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		map("n", "<leader>/", builtin.find_files, { desc = "[S]earch [F]iles" })
		map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		map("n", "<leader><leader>", builtin.resume, { desc = "[S]earch [R]esume" })
		map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		map("n", "<leader>sb", builtin.buffers, { desc = "[ ] Find existing buffers" })
		map("n", "<leader>st", builtin.tags, { desc = "[S]earch [T]ags" })

    -- Coc integration
    map("n", "<leader>ss", ":<C-u>Telescope coc workspace_symbols<cr>", { desc = "[S]earch workspace [S]ymbols" })
    map("n", "<leader>so", ":<C-u>Telescope coc document_symbols<cr>", { desc = "[S]earch d[o]cument symbols" })
    map("n", "gr", ":<C-u>Telescope coc references<cr>", { desc = "[G]oto [R]eferences" })
    map("n", "gD", ":<C-u>Telescope coc definitions<cr>", { desc = "[G]oto [D]efinition" })
    map("n", "gT", ":<C-u>Telescope coc type_definitions<cr>", { desc = "[G]oto to [T]ype definitions" })
    map("n", "gI", ":<C-u>Telescope coc implementations<cr>", { desc = "[G]oto to [I]mplementations" })

		-- Fuzzy find all the symbols in your current document.
		--  Symbols are things like variables, functions, types, etc.
		-- map("n", "<leader>so", builtin.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })

		-- Jump to the definition of the word under your cursor.
		--  This is where a variable was first declared, or where a function is defined, etc.
		--  To jump back, press <C-t>.
		-- map("n", "gd", builtin.lsp_definitions, { desc = "[G]oto [D]efinition" })

		-- Find references for the word under your cursor.
		-- map("n", "gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })

		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		-- map("n", "gi", builtin.lsp_implementations, { desc = "[G]oto [I]mplementation" })

		-- Jump to the type of the word under your cursor.
		--  Useful when you're not sure what type a variable is and you want to see
		--  the definition of its *type*, not where it was *defined*.
		-- map("n", "gt", builtin.lsp_type_definitions, { desc = "Type [D]efinition" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sc", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
