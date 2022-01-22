{ config, pkgs, ... }:

{

  imports = [ ./dotfiles/git.nix ./dotfiles/tmux.nix ./dotfiles/neovim.nix ];

  home = {
    packages = with pkgs; [
      tree
      file
      fd
      golangci-lint
      mosh
      highlight
      rust-analyzer
      ffmpeg
      stylua
      gopls
      reattach-to-user-namespace
      starship
      zsh
      fish
      rnix-lsp
      yarn
      nixpkgs-fmt
      nixpkgs-review
      pypi2nix
      rustc
      cargo
      nodePackages.node2nix
      nixfmt
      nodePackages.typescript-language-server

      (python39.withPackages (ps: with ps; [ pip powerline pygments pynvim ]))
    ];
  };

  programs = {
    home-manager.enable = true;
    gpg.enable = true;
    fzf.enable = true;
    jq.enable = true;
    bat.enable = true;
    command-not-found.enable = true;
    dircolors.enable = true;
    htop.enable = true;
    info.enable = true;

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
    };
  };
}
