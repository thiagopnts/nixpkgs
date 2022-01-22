# Usage

Install Nix and home-manager



```bash
$ nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz home-manager

$ nix-channel --update

$ nix-shell '<home-manager>' -A install
# add this if install fails with NIX_PATH unbound error and run nix-shell install again
$ echo 'export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\n' >> ~/.bash_profile
$ echo 'export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\n' >> ~/.zshenv
```

```bash
$ git clone https://github.com/thiagopnts/nixpkgs.git ~/.config/nixpkgs
 
$ home-manager switch --flake ~/.config/nixpkgs/#$USER -v
```
