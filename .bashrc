#
# ~/.bashrc
#

[[ $- != *i* ]] && return

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

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
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
		PS1='\[\033[01;31m\][*･ﾟ✧ \h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
        PS1='\[\033[01;32m\][*･ﾟ✧ \h\[\033[01;37m\]\033[37m \W\033[0m\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# customization
cd /home/kewbish/Downloads/dev

export evb=/home/kewbish/EVB
export dev=/home/kewbish/Downloads/dev
export pers=/home/kewbish/Downloads/personal
export edu=/home/kewbish/Downloads/education

export VISUAL=nvim
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='-m --border --height 40%'

alias tock='python /home/kewbish/Downloads/dev/pers/tock/tock.py'
alias clc='EDITOR=nvim calcurse'
alias evb='cd /home/kewbish/EVB/;nvim -o "$(rg --files -g '!archive/' $evb | fzf)"'
alias latexmk='latexmk -pvc -pdf -interaction=nonstopmode'
# alias fso-cp="\cp -r ./ /home/kewbish/Downloads/dev/kewbish-fso/"
alias cpsc213='cd /home/kewbish/EVB/cpsc213/;nvim -o "$(fzf)"'
alias cpsc221='cd /home/kewbish/EVB/cpsc221/;nvim -o "$(fzf)"'
alias fren202='cd /home/kewbish/EVB/fren202/;nvim -o "$(fzf)"'
alias cogs200='cd /home/kewbish/EVB/cogs200/;nvim -o "$(fzf)"'
alias cpsc448='cd /home/kewbish/EVB/cpsc448/;nvim -o "$(fzf)"'
alias yours='cd /home/kewbish/EVB/yours/;nvim -o "$(fzf)"'
alias readings='cd /home/kewbish/EVB/readings/;nvim -o "$(fzf)"'
# alias fleet='cd /home/kewbish/EVB/tmp/;nvim -o "$(fzf)"'
alias :q=exit
alias ytdl='youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" --write-sub --retries 10'
alias subrip='for i in *.vtt; do ffmpeg -i "$i" -c:s subrip "${i%.*}.srt"; done'
# alias clcsync='calcurse-caldav --init=keep-remote --authcode "4/0AX4XfWhLCBDWLnlwyZY5sYGnrleVkyETeoIDPgRtFFwIjDIpggsFedm8nH8MtlsuHutd2g"'
# alias repl='cd /home/kewbish/Downloads/dev/replit'
# alias replit='cd /home/kewbish/EVB/replit/;nvim -o "$(fzf)"'
alias tmrwtodo='python /home/kewbish/Downloads/dev/tmp/tmrw_todo.py'
alias 7='dijo'
alias ptoi='pdftoppm -png'
alias 221mount='sshfs kewbish@remote.students.cs.ubc.ca:/home/k/kewbish/cpsc221/ /home/kewbish/Downloads/education/cpsc221/remote'
alias 213mount='sshfs kewbish@remote.students.cs.ubc.ca:/home/k/kewbish/cpsc213/ /home/kewbish/Downloads/education/cpsc213/remote'

shopt -s direxpand

xtog() {
    if pgrep xcompmgr &>/dev/null; then
        echo "Turning xcompmgr OFF"
        pkill xcompmgr &
    else
        echo "Turning xcompmgr ON"
        xcompmgr -c -l0 -t0 -r0 -o.00
    fi
    exit 0
}

battog() {
    if [[ "$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)" == 1 ]]; then
        sudo sh -c "echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
    else
        sudo sh -c "echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
    fi
}
alias batstate='cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'

cpmkrn() {
    name=$(echo $1 | sed "s/.cpp/.out/")
    g++ -std=c++11 -O2 -Wall $1 -o $name
    ./$name
}

ptoineg () {
    infile=$1
    outprec=$2
    pdftoppm -png $infile $outprec
    for f in $outprec*.png ; do convert -negate $f $f ; done
}

export PATH=/home/kewbish/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/kewbish/.npm-global/bin:/home/kewbish/.npm-global/lib/node_modules/yarn/bin/:/usr/lib/ruby/2.7.0/:/home/kewbish/.fly/bin:/home/kewbish/.jdks/corretto-11.0.16.1/bin:/home/kewbish/go/bin


source /etc/profile.d/google-cloud-sdk.sh

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

alias vim=nvim

export GOPATH=/home/kewbish/go

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
