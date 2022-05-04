{ config, pkgs, ... }:
{
  home.sessionVariables = {
    TERMINAL="kitty";
  };

  programs.kitty = {
    enable = false;
    settings = {
      enable_audio_bell = "no";
#      bindkey = "\"\\e[1;3D\" backward-word # ‚M-^L•‚M-^FM-^P";
#      bindkey = "\"\\e[1;3C\" forward-word # ‚M-^L•‚M-^FM-^R";
      cursor_shape = "block";
      macos_option_as_alt = "yes";
      font_size = "16.0";
      font_family = "Cascadia Code";
      bold_font   = "auto";
      italic_font =     "auto";
      bold_italic_font = "auto";
      disable_ligatures = "never";
      hide_window_decorations = "yes";
      window_margin_width = "2";
      window_border_width = "1pt";
      background = "#111111";
      foreground = "#dedede";
      cursor =     "#ffa460";
      selection_background = "#464d91";
      selection_foreground = "#111111";
      color0 =  "#919191";
      color1 =  "#e17373";
      color2 =  "#94b978";
      color3  = "#ffb97b";
      color4 =  "#96bddb";
      color5 =  "#e1c0fa";
      color6 =  "#00988e";
      color7 =  "#dedede";
      color8 =  "#bdbdbd";
      color9 =  "#ffa0a0";
      color10 = "#bddeab";
      color11 = "#ffdba0";
      color12 = "#b1d7f6";
      color13 = "#fbdaff";
      color14 = "#19b2a7";
      color15 = "#ffffff";
    };
  };
}
