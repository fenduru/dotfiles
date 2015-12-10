export ZSH=/home/joshfee/.oh-my-zsh

ZSH_THEME="agnoster"

plugins=(
  bower
  colored-man-pages
  command-not-found
  common-aliases
  compleat
  extract
  z
  git
  node
  npm
  nvm
)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin"

source $ZSH/oh-my-zsh.sh
