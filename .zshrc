## MacOS prerequisits
# brew install coreutils


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


get_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


# Sort ls output dirs first, than dunderscore filenames.
export LC_COLLATE=C

# set default text editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '( %b )'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%n | ${PWD/#$HOME/~} ${vcs_info_msg_0_} > '


if [ "$RUNNING_SYSTEM" = "macosx" ]; then
    echo "setting macosx preferences"

    export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"
    alias ls="ls --color=auto"
    alias lsd="ls --color=always --group-directories-first"

    # This has to be executed only once per system configuration.
    # The following command makes windows resizing much smoother.
    # defaults write -g NSWindowResizeTime -float 0.003

else
    echo "setting linux preferences"
    alias ls="ls --color=auto"
    alias lsd="ls --color=always --group-directories-first"
fi


if [ "$RUNNING_SYSTEM" = "macosx" ]; then
    alias grep=ggrep
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

# Load secret config  (API keys, etc...)
[ -f ~/.secrets ] && source ~/.secrets

# https://github.com/junegunn/fzf
# configure fzf fuzzy-search for shell  (use by <Ctrl-T>
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
