vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Theme
    -- use 'Mofiqul/vscode.nvim'

    -- Navigator / Search
    use 'christoomey/vim-tmux-navigator'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Git
    use 'lewis6991/gitsigns.nvim'
    use({
        "kdheepak/lazygit.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    -- Helper
    use 'mbbill/undotree'
    use "lukas-reineke/indent-blankline.nvim"
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
    use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})
    use {
        '3rd/image.nvim',
        config = function()
            require('image').setup({
                backend = 'kitty', 
            })
        end,
    }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use({
        'nvimtools/none-ls.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
    })
    use {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",

        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets"
    }

    -- Debugger
    use {
        'mfussenegger/nvim-dap',
        commit = '7ff6936010b7222fea2caea0f67ed77f1b7c60dd',
    }
    use {
        'rcarriga/nvim-dap-ui',
        requires = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    }
    use {
        'theHamsta/nvim-dap-virtual-text',
        requires = { 'mfussenegger/nvim-dap' },
    }
    use {
        'mxsdev/nvim-dap-vscode-js',
        requires = {
            'mfussenegger/nvim-dap',
            {
                'microsoft/vscode-js-debug',
                opt = true,
                run = 'npm i && npm run compile vsDebugServerBundle && mv dist out',
            },
        },
    }

    use({
        "nickjvandyke/opencode.nvim",
        tag = "*",
    })
end)
