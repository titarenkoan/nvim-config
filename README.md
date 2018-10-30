# nvim-config
My neovim configuration file
# Installation guide
1. Download vim-plug pluggin manager:

`$ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

2. Put `init.vim` config file into ~/.config/nvim directory.
3. `pip3 install neovim`
4. Run neovim and execute `PlugInstall` command.

## MacOS
5. To enable YCM support (it will output a warning during the last step), go to `~/.local/share/nvim/plugged/YouCompleteMe` and type:

`./install.py --clang-completer`

This will compile YCM with C-family languages support. See https://valloric.github.io/YouCompleteMe/#mac-os-x for details.

## Linux
5. To enable YCM support (it will output a warning during the last step), go to `~/.local/share/nvim/plugged/YouCompleteMe` and type:

`python3 install.py --clang-completer`

This will compile YCM with C-family languages support. See https://valloric.github.io/YouCompleteMe/#linux-64-bit for details.

6. Your terminal must be able to display non-ASCII symbols which are part of layout. In `fonts/` folder you may
find .ttf font for your terminal application.

## Note

* YCM may require (see YCM guide for details) config file in project's root to enable C/C++ completions. You may find it in 
`ycm-config/` folder.

* Also I use Flake8 for linting, so you'll probably need to install it too. Use, e.g.
`pip install flake8`
