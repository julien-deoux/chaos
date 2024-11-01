{
  config,
  pkgs,
  ...
}:

let
  tmuxDarkNotify = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "darkNotify";
    version = "unstable-2024-11-01";
    src = pkgs.fetchFromGitHub {
      owner = "erikw";
      repo = "tmux-dark-notify";
      rev = "dfa2b45b3edab2fbd6961bdb40b2a7c50fc17060";
      sha256 = "naOIotyAgUHZ2qSPmvLMkxGeU0/vfQYrFPjO7Coig0g=";
    };
  };
in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "julien";
  home.homeDirectory = "/Users/julien";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.nixd
    pkgs.nixfmt-rfc-style

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/julien/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Julien Déoux";
    userEmail = "juliendeoux@gmail.com";
    ignores = [
      ".DS_Store"
      ".ignore"
    ];
    aliases = {
      cf = "config";
      a = "add";
      ci = "commit";
      ps = "push";
      pf = "push --force-with-lease";
      s = "status";
      cl = "clone";
      co = "checkout";
      pl = "pull";
      st = "stash";
      rb = "rebase";
      f = "fetch";
      br = "branch";
      l = "log";
      ro = "restore";
      rs = "reset";
      m = "merge";
      cp = "cherry-pick";
    };
    extraConfig = {
      core.editor = "nvim";
      advice.addIgnoredFile = false;
      pull.rebase = true;
      fetch.prune = true;
      rerere.enabled = true;
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-a";
    terminal = "screen-256color";
    baseIndex = 1;
    mouse = true;
    sensibleOnTop = false;
    plugins = [
      # Navigate panes and nvim with Ctrl-hjkl
      pkgs.tmuxPlugins.vim-tmux-navigator
      # Copy with Y
      pkgs.tmuxPlugins.yank
      # Light/Dark mode
      {
        plugin = tmuxDarkNotify;
        extraConfig = ''
          set -g @dark-notify-theme-path-light /Users/julien/git/gaia/tmux/light.conf
          set -g @dark-notify-theme-path-dark /Users/julien/git/gaia/tmux/dark.conf
          if-shell "test -e /Users/julien/.local/state/tmux/tmux-dark-notify-theme.conf" \
               "source-file /Users/julien/.local/state/tmux/tmux-dark-notify-theme.conf"
        '';
      }
    ];
    extraConfig = ''
      # Better colors
      set-option -sa terminal-overrides ",xterm*:Tc"

      # Address vim mode switching delay (http://superuser.com/a/252717/65504)
      set -s escape-time 0
      # Increase scrollback buffer size from 2000 to 50000 lines
      set -g history-limit 50000
      # Increase tmux messages display duration from 750ms to 4s
      set -g display-time 4000
      # Refresh 'status-left' and 'status-right' more often, from every 15s to 5s
      set -g status-interval 5

      set-option -g status-position top
      # Split panes
      unbind %
      bind v split-window -h -c "#{pane_current_path}"
      unbind '"'
      bind s split-window -v -c "#{pane_current_path}"
      # Reload configuration
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf
      # Window navigation
      bind -r l next-window
      bind -r h previous-window
      # Session navigation
      bind -r j switch-client -n
      bind -r k switch-client -p

      # start selecting text with "v"
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      # rectangle selection
      bind-key -T copy-mode-vi v send-keys -X rectangle-toggle
      # copy text with "y"
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      # don't exit copy mode after dragging with mouse
      unbind -T copy-mode-vi MouseDragEnd1Pane
    '';
  };

  programs.starship = {
    enable = true;
    settings.command_timeout = 1000;
  };
}
