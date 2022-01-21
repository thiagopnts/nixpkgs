# Usage

Install Nix and home-manager

```bash
$ nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz home-manager

$ nix-channel --update

$ nix-shell '<home-manager>' -A install
```

```bash
$ git clone https://github.com/thiagopnts/nixpkgs.git ~/.config/nixpkgs
 
$ home-manager switch --flake ~/.config/nixpkgs/#$USER -v
```
