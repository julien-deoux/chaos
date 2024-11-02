{ ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      g = "git";
      v = "nvim";
      t = "nvim ~/todo.md";
    };
    interactiveShellInit = ''
      set -gx PNPM_HOME $HOME/Library/pnpm
      set -gx BUN_INSTALL $HOME/.bun
      set -gx PATH $BUN_INSTALL/bin $PATH
      set -gx PATH $HOME/go/bin/ $PATH
      set fish_greeting
    '';
  };
}