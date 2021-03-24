
# exports environment variables
export PYENV_ROOT="/Users/klein/.pyenv"
export PATH="/Users/klein/.pyenv/bin:/Users/klein/.pyenv/shims:/Users/klein/.pyenv/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$PATH:/Users/klein/.local/bin"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"

# aliases
alias x="xonsh"
alias ls="exa --time-style=long-iso -g"
alias ll="ls --git --time-style=long-iso -gl"
alias la="ls --git --time-style=long-iso -agl"
alias l1="exa -1"
alias l="ll"
alias cat="bat"

# initialize settings
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

x
