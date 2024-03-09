{ configm, pkgs, ... }:
{
  programs.zsh = {
  plugins = [
	{
		name = "powerlevel10k";
		src = pkgs.zsh-powerlevel10k;
		file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
	}
	{
		name = "powerlevel10k-config";
		src = ./p10k-cfg;
		file = "p10k.zsh";
	}
  ];
  enable = true;
    oh-my-zsh = {
	enable = true;
	plugins = [ "git" ];
    };
  };
}
