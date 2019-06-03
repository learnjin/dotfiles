Dotfiles
========

This is my collection of [configuration files](http://dotfiles.github.io/).

Usage
-----

Pull the repository, and then create the symbolic links [using GNU
stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/).

macOS with Homebrew:
```bash
$ brew install stow
```

Ubuntu:
```bash
$ apt install stow
```

```bash
$ git clone git@github.com:learnjin/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow neovim tmux # plus whatever else you'd like
```

Cosmetics
---------
Install [base16 shell](https://github.com/chriskempson/base16-shell) and a supported
terminal emulator like iTerm2, Kitty.

License
-------

[MIT](http://opensource.org/licenses/MIT).
