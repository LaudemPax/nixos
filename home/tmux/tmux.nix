{ ... }:
{
  programs.tmux = {
      enable = true;
      extraConfig = ''
          # Use 256 colors for terminal
          set -g default-terminal "screen-256color"

          # If you still face issues, uncomment the following line to override terminal capabilities
          set -ga terminal-overrides ',xterm-256color:Tc,konsole-256color:Tc'

          # Change the modifier key to <Ctrl+Space>
          unbind C-b
          set -g prefix C-Space
          bind C-Space send-prefix

          # Change window vertical split to mod+v, horizontal split to mod+h
          unbind '"'
          unbind %
          bind v split-window -h
          bind h split-window -v

          # Rebind moving to the corresponding pane using prefix + arrow keys
          bind Left select-pane -L
          bind Right select-pane -R
          bind Up select-pane -U
          bind Down select-pane -D
          '';
  };
}
