#w================= #
# CHECK INTERACTIVE #
# ================= #
[[ $- != *i* ]] && return

# ======= #
# STARTUP #
# ======= #
fastfetch
printf "Welcome to the bash shell Alex!\n"

# ============== #
# PATH VARIABLES #
# ============== #
export PATH='/usr/bin:/usr/bin/local:/bin:/root/.local/bin'
export JAVA='/usr/bin/java'

# ============= #
# ENV VARIABLES #
# ============= #
export PAGER="less"
export EDITOR="nvim"
export QT_SELECT=4
export GITHUB='git@github.com:tgnlex'
export WORDS="/usr/share/dict/words"


# ==================== #
# SOFT LINK FILE PATHS #
# ==================== #
export DOTFILES_DIR='/config/dotfiles' # DOTFILES 
export CONFIGS_DIR='/config'   # LINUX CONFIG 

# ======================== #
# CONFIG SOURCE FILE PATHS #
# ======================== #
export XONSHRC_SRC="/config/dotfiles/.xonshrc"  # XONSHRC MAIN SOURCE FILE
export BASHRC_SRC="/config/dotfiles/.bashrc"    # BASHRC MAIN SOURCE FILE
export VIMRC_SRC="/config/dotfiles/.vimrc"      # VIMRC MAIN SOURCE FILE
export BASH_ALIASES_SRC="/config/dotfiles/.bash_aliases"   # BASH ALIASES SOURCE FILE 
export INPUTRC_SRC="/config/dotfiles/.inputrc" # INPUT RC FILE 
export TMUX_SRC="/config/dotfiles/.tmux.conf"  # TMUX CONFIG FILE

# =================== #
# IMPORT BASH ALIASES # 
# =================== #
if [[ -e ~/.bash_aliases ]]; then
  source ~/.bash_aliases
fi

# ============= #
# SHELL OPTIONS #
# ============= #

shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend

# =============== #
# SHELL FUNCTIONS #
# =============== #


ckdir() {
  local DIR = "$1"
  mkdir "$DIR"
  cd "$DIR"
}

die() {
  echo '[FATAL]' "$@" >&2
  exit 1
}

spin() {
  local c 
  while true; do 
    for c in ' / ' ' | ' ' \ ' ' - '; do 
      printf '\r%s' "$c"
 \     sleep .2
    done 
  done 
}

backup-all() {
  for file in *.$1 ; do 
    cp "$file" "$file.bak"
  done
}
# =================== #
# IMPORT BASH ALIASES # 
# =================== #

# ===============#
# DEFAULT CONFIG #
# ============== #
colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			printf "  %-9s" "${seq0:-(default)}"
      printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}


# BASH COMPLETION # 
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# TERMINAL PROMPT # 
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.

safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
  for ((i = 0; i < 10; i++)); do
   echo "$i"
  done
fi



xhost +local:root > /dev/null 2>&1
