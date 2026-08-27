fastfetch
printf "Welcome to Z-Shell Alex!\n"

PAGER="less"
EDITOR="nvim"
QT_SELECT=4
GITHUB='git@github.com:tgnlex'
WORDS="/usr/share/dict/words"
USE_POWERLINE="true"
HAS_WIDECHARS="false"

XONSHRC_SRC="/config/dotfiles/.xonshrc"  # XONSHRC MAIN SOURCE FILE
BASHRC_SRC="/config/dotfiles/.bashrc"    # BASHRC MAIN SOURCE FILE
ZSHRC_SRC="/config/dotfiles/.zshrc"      # ZSHRC MAIN SOURCE FILE 
VIMRC_SRC="/config/dotfiles/.vimrc"      # VIMRC MAIN SOURCE FILE
BASH_ALIASES_SRC="/config/dotfiles/.bash_aliases"   # BASH ALIASES SOURCE FILE 


if [[ -e ~/.bash_aliases ]]; then
  source ~/.bash_aliases
fi

# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi
