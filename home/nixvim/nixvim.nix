{ ... }:
{
    programs.nixvim = {
        enable = true;
        globals = {
            mapleader = " ";
        };
        options = {
            nu = true; 
            relativenumber = true;
            tabstop = 4;
            softtabstop = 4;
            shiftwidth = 4;
            expandtab = true;
            smartindent = true;
            wrap = false;
            swapfile = false;
            backup = false;
            undofile = true;
            hlsearch = true;
            incsearch = true;
            termguicolors = true;
            signcolumn = "yes";
            updatetime = 50;
        };
        colorschemes.tokyonight = {
            enable = true;
            style = "storm";
        };
        plugins = {
            lualine.enable = true;

            oil.enable = true;
            
            bufferline.enable = true;

            telescope.enable = true;

            treesitter.enable = true;

            nvim-tree = {
                enable = true;
                openOnSetup = true;
                openOnSetupFile = true;
                sortBy = "case_sensitive";
                renderer = {
                    groupEmpty = true;
                };
                view = {
                    relativenumber = true;
                    side = "right";
                };
            }; 

            lsp = {
                enable = true;
                servers = {
                    # lua
                    lua-ls.enable = true;
                    # nix
                    nil_ls.enable = true;
                };
            };
            cmp = {
                enable = true;
                settings = {
                    mapping = {
                        __raw = ''
                            cmp.mapping.preset.insert({
                                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                                    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                                    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                                    ['<C-Space>'] = cmp.mapping.complete(),
                                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                                    ['<Esc>'] = cmp.mapping.close(),
                                    })
                        '';
                    };
                    snippet = {
                        expand = "function(args) require('luasnip').lsp_expand(args.body) end";
                    };
                    autoEnableSources = true;
                    sources = [
                    {name = "nvim_lsp";}
                    {name = "path";}
                    {name = "buffer";}
                    ];
                };
            };

        };
        extraConfigLua = ''
            -- nvim-tree keymap
            local nvimtree_api = require("nvim-tree.api")
            vim.keymap.set('n', '<leader>f', nvimtree_api.tree.toggle)
        '';
    };
}
