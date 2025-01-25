# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
# pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"
# chruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.3.5 # run chruby to see installed versions
# Go
export PATH=$PATH:$HOME/go/bin
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/chandler/.lmstudio/bin"
