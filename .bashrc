fortune | cowsay;


# If not running interactively, don't do anything                                                                                                                                                                                                                                                                 
case $- in
    *i*) ;;
      *) return;;
esac


case "$(uname -s)" in
    Darwin)
        RUNNING_SYSTEM="macosx"
        ;;
    Linux)
        RUNNING_SYSTEM="linux"
        ;;
esac


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


get_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


# Sort ls output dirs first, than dunderscore filenames.
export LC_COLLATE=C

# set default text editor
export VISUAL=vim
export EDITOR="$VISUAL"

# set prompt format
export PS1="\u@\h\$(get_git_branch) $ "

# history configuration
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000


# Enable programmable sdb completion features.
if [ -f ~/.sdb/.sdb-completion.bash ]; then
 source ~/.sdb/.sdb-completion.bash
fi

if [ "$RUNNING_SYSTEM" = "macosx" ]; then
    echo "setting macosx preferences"
    alias ls="gls --color=auto"
    alias lsd="ls --color=always --group-directories-first"
else
    echo "setting linux preferences"
    alias ls="ls --color=auto"
    alias lsd="ls --color=always --group-directories-first"
fi

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias nextbr='git checkout $(next-branch)'
alias prevbr='git checkout $(prev-branch)'
alias xo='xdg-open'
alias activate="source env/bin/activate"


cdp() {
    cd $(find $(eval echo "~/dev/") -name $1)
}

vimf() {
    vim $(find . -name $1) $@
}

grepp () {
    find . -iname $1 -exec grep -nH $2 {} \;
}

clean-dir () {
    find . -iname "__pycache__" -prune -exec rm -rf {} \;
    find . -iname "*.pyc" -exec rm {} \;
}

next-branch() {
    bname=$(git branch | grep --after-context 1 "\*" | grep -v "\*" | sed "s/\s\+//")
    if [ -z "$bname" ]; then
        bname=$(git branch | head -n 1)
    fi
    echo $bname
}

prev-branch() {
    bname=$(git branch | grep --before-context 1 "\*" | grep -v "\*" | sed "s/\s\+//")
    if [ -z "$bname" ]; then
        bname=$(git branch | tail -n 1)
    fi
    echo $bname
}

lsnames() {
    lsd $@ | awk 'NF >= 3 {print $(NF)}'
}
