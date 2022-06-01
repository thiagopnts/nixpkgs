{ config, pkgs, ... }:

{

  imports = [ ./dotfiles/git.nix  ./dotfiles/kitty.nix ];

  home = {
    packages = with pkgs; [
      tree
      file
      cascadia-code
      fd
      mosh
      highlight
      ffmpeg
      reattach-to-user-namespace
      starship
      zsh
      fish
      yarn
      nixpkgs-fmt
      nixpkgs-review
      pypi2nix
      nodePackages.node2nix
      nixfmt
      #rustc
      #rustfmt
      #clippy
      #cargo
      #rust.packages.stable.rustPlatform.rustLibSrc

      (python39.withPackages
        (ps: with ps; [ pip powerline pygments pynvim pipenv ]))
    ];
  };

#  home.sessionVariables = {
#    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
#  };

  programs = {
    bash = {
      enable = true;
      initExtra = ''
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      '';
    };
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
