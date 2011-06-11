source ~/dotfiles/aliases
source ~/dotfiles/bash_completions/git_completion

# Enable vi mode
set -o vi

# Default editor
export EDITOR="/usr/local/bin/vim"

# History
# ignore any commands starting with fg from history
export HISTIGNORE="fg*"
export HISTCONTROL=erasedups	# when adding an item to history, delete itentical commands upstream
export HISTSIZE=10000		# save 10000 items in history
shopt -s histappend		# append history to ~\.bash_history when exiting shell

# Prompt: must come after the git-completion script
PS1='[\W$(__git_ps1 " (%s)")]\$ '
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'

# Paths
export PATH="~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:/opt/local/bin:/opt/local/sbin:$PATH"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home


if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
