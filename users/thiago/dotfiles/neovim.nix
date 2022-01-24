{ config, pkgs, ... }:

{
  xdg.configFile.nvim = {
    source = ./neovim;
    recursive = true;
  };
  programs.neovim = {
    package = pkgs.neovim-nightly;
    enable = true;
    vimAlias = true;
    plugins = with pkgs; [ vimPlugins.packer-nvim ];
    extraConfig = ''
      " This works on NixOS 21.05
      execute "source ~/.config/nvim/start.lua"
    '';
  };
}
