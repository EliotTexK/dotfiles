#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Add path for home/bin and /home/eliot/.local/bin
export PATH="$PATH:/home/eliot/bin:/home/eliot/.local/bin"

# minimalist bold yellow prompt, with white text just the way I like it
PS1="\[\033[01;93m\]>> \[\033[00;00m\]"

# how I like ls to work
alias ls="ls --group-directories-first --color=auto"

# show directories with cd
cdfunc() {
	cd $1
	pwd
	ls
}
alias cd=cdfunc
