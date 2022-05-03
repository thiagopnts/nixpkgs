{ pkgs, ... }:

{
  programs = {
    tmux = {
      enable = true;
      # terminal = "xterm-256color";
      # terminal = "screen-256color";
      terminal = "xterm-kitty";
      historyLimit = 406000;
      prefix = "`";
      baseIndex = 1;
      plugins = with pkgs; [ tmuxPlugins.resurrect tmuxPlugins.continuum ];
      shell = "${pkgs.zsh}/bin/zsh";
      extraConfig = ''
        set-option -g default-command "reattach-to-user-namespace -l ${pkgs.zsh}/bin/zsh"

        set -g focus-events on

        set-option -g default-shell ${pkgs.zsh}/bin/zsh
        # this might not work
        # set-option -ga terminal-overrides ",*256col*:Tc"

        # undercurl support
        set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
        # underscore colours, needs tmux v3+
        set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

        # new status settings

        set -g status-justify "left"
        set -g status "on"
        set -g status-left-style "none"
        set -g message-command-style "fg=colour144,bg=colour237"
        set -g status-right-style "none"
        set -g pane-active-border-style "fg=#3c3836"
        set -g status-style "bg=colour234,none"
        set -g message-style "fg=colour144,bg=colour237"
        set -g pane-border-style "fg=colour237"
        set -g status-right-length "150"
        set -g status-left-length "200"
        #setw -g window-status-activity-attr "none"
        setw -g window-status-activity-style "fg=colour27,bg=colour234,none"
        setw -g window-status-separator ""
        setw -g window-status-style "fg=colour39,bg=colour234,none"
        #set -g status-attr none
        setw -g monitor-activity on

        tmux_bg_color='#3c3836'
        tmux_fg_color='#a89984'
        tmux_high_contrast='fg=#282828,bg=#83a598,bold'
        tmux_normal_contrast='fg=#282828,bg=#fabd2f,nobold'
        tmux_low_contrast='fg=#ebdbb2,bg=#504945'
        sep='#[fg=#504945]│#[default]'

        set -g status-bg $tmux_bg_color
        set -g status-fg $tmux_fg_color
        set -g status-left "#[$tmux_high_contrast] #{pane_current_path} #[$tmux_normal_contrast]#{simple_git_status}#[$tmux_low_contrast] #P/#{window_panes} "
        set -g status-right "#{battery_status_fg}#{battery_icon}#{battery_percentage} #{prefix_highlight}$sep #{online_status} $sep #{sysstat_cpu} $sep #{sysstat_mem} $sep #{sysstat_swap} #[$tmux_low_contrast] %d.%m.%Y │ #[$tmux_low_contrast]%H:%M #[$tmux_high_contrast] #h "
        setw -g window-status-format "#[fg=$tmux_fg_color,bg=$tmux_bg_color] #W #F "
        setw -g window-status-current-format "#[$tmux_high_contrast] #W #F "


        set -g status-bg colour233
        set -g status-fg white
        set -g base-index 1
        set -g mouse on
        #set -g mouse-resize-pane off
        #set -g mouse-select-pane off
        #set -g mouse-select-window off

        # to avoid "can't find panel error with tmuxinator"
        set-window-option -g pane-base-index 1

        # redefine prefix bind to `
        set -g prefix `
        bind-key ` send-prefix

        #mouse scrolling ftw
        bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'"
        bind -n WheelDownPane select-pane -t= \; send-keys -M

        set-option -g status-position bottom
        set-option -g status-interval 1
        #set -g status-left-length 100
        #set -g status-right-length 80
        #set -g status-left "#[fg=gray] #(git branch --no-color | sed -e '/^[^*]/d' -e 's/* //')ᚠ #[fg=white]#{pane_current_path} "
        #set -g status-right "#(type -q kubectl && (kubectl config current-context)) #(ifconfig en0 | grep 'inet ' | awk '{print \"en0 \" $2}') #(ifconfig en1 | grep 'inet ' | awk '{print \"en1 \" $2}') #[fg=red]#(ifconfig tun0 | grep 'inet ' | awk '{print \"vpn \" $2}')"
        #set-option -g status-position bottom

        set-window-option -g mode-keys vi
        bind -Tcopy-mode-vi v send -X begin-selection
        bind -Tcopy-mode-vi y send -X copy-selection

        # remove tmux esc delay(it's annoying when using vim)
        set -sg escape-time 0

        # open urls from tmux. It's useful when using IRC
        #bind-key u capture-pane \; save-buffer /tmp/tmux-buffer \; split-window -l 10 "urlview /tmp/tmux-buffer"

        # Smart pane switching with awareness of Vim splits.
        # See: https://github.com/christoomey/vim-tmux-navigator
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
        tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
        if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
        if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        bind-key -T copy-mode-vi 'C-\' select-pane -l
              '';
    };
  };
}
