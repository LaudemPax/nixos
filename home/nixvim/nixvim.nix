{ ... }:
{
    programs.nixvim = {
        enable = true;
        globals = {
            mapleader = " ";
        };
        opts = {
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
            scrolloff = 10;
        };
        colorschemes.tokyonight = {
            enable = true;
            settings= {
                style = "storm";
                on_colors = "function(colors) colors.fg_gutter = '#b2b8cf' end";
            };
        };
        plugins = {
            lualine.enable = true;

            oil = {
                enable = true;
                settings = {
                    default_file_explorer = true;
                };
            };
            
            bufferline = {
                enable = true;

            };

            telescope = {
                enable = true;
            };

            treesitter.enable = true;

            nvim-tree = {
                enable = true;
                openOnSetupFile = true;
                sortBy = "case_sensitive";
                renderer = {
                    groupEmpty = true;
                };
                view = {
                    relativenumber = true;
                    side = "right";
                    width = {
                        min = 50;
                        max = -1;
                    };
                };
                git = {
                    enable = true;
                    ignore = false;
                };
            }; 

            lsp = {
                enable = true;
                servers = {
                    # lua
                    lua-ls.enable = true;
                    # nix
                    nil_ls.enable = true;
                    # xml 
                    lemminx.enable = true;
                    # python
                    pyright.enable = true;
                };
            };

            # formatting on save
            lsp-format = {
                enable = true;
                lspServersToEnable = "all";
            };

            # commenting lines
            comment = {
                enable = true;
            };

            leap = {
                enable = true;
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

            toggleterm = {
                enable = true;
                settings = {
                    direction="horizontal";
                    insert_mappings=false;
                    open_mapping="[[<leader>t]]";
                };
            };

        };
        keymaps = [
           {
                action = "<cmd>BufferLinePick<CR>";
                key = "<leader>e";
                mode = "n";
                options = {
                    silent = true;
                };
           }
           {
               action = {
                   __raw = ''
                       require("nvim-tree.api").tree.toggle
                   '';
               };
               key = "<leader>f";
               mode = "n";
               options = {
                   silent = true;
                   noremap = true;
               };
           }
        ];
        extraConfigLua = ''
            -- comment.nvim keymap
            vim.keymap.set("n", "<leader>c", function() require('Comment.api').toggle.linewise.current() end, { noremap = true, silent = true })

            -- telescope stuff
            require('telescope').setup({
                defaults = {
                    file_ignore_patterns = {
                        "node_modules/*",
                        ".git/*",
                        "*/node_modules/*"
                    }
                }
            });

            local tsbuiltin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', tsbuiltin.find_files, {})
            '';
    };
}

