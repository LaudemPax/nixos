{ configm, pkgs, ... }:
{
	programs.nixvim = {
		enable = true;
		colorschemes.tokyonight = {
		    enable = true;
		    style = "storm";
		};
		plugins = {
   		    lualine.enable = true;
		    lsp = {
			enable = true;
			servers = {
			   # lua
			   lua-ls.enable = true;

			   # nix
			   nixd.enable = true;
			};
		    };
		};
	};
}

