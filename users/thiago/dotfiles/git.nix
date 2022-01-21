{ pkgs, ... }:

{

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      userName = "Thiago Pontes";
      userEmail = "code@thiago.me";
      ignores = [ "*~" "*.swp" ".DS_Store" ];
      aliases = {
        st = "status -sb";
        ci = "commit";
        br = "branch";
        co = "checkout";
        pullr = "pull --rebase";
        df = "diff";
        dfs = "diff --staged";
        dc = "diff --cached";
        lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
        lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
        lg = "log --stat";
        ls = "ls-files";
      };
      extraConfig = {
        url."git@github.vimeows.com:".insteadOf = "https://github.vimeows.com/";
        url."ssh://git@github.vimeows.com".insteadOf = "https://github.vimeows.com";
        init.defaultBranch = "main";
        core.editor = "nvim";
        status = { showUntrackedFiles = "all"; };
        remote = {
          push = [
            "refs/heads/*:refs/heads/*"
            "refs/tags/*:refs/tags/*"
          ];

          fetch = [
            "refs/heads/*:refs/remotes/origin/*"
            "refs/tags/*:refs/tags/*"
          ];
        };

        color = {
          ui = "auto";
          branch = {
            current = "yellow reverse";
            local = "yellow";
            remote = "green";
          };
        };

        push = {
          default = "simple";
        };

        pull = {
          rebase = true;
        };

        rebase = {
          stat = true;
          autoSquash = true;
          autostash = true;
        };
      };
    };
  };

}
