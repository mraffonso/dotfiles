# Dont' forget to load plugins in .zshrc

# Shortcuts
r=$HOME/repos
r() { cd ~/repos/$1; }
_r() { _files -W ~/repos -/; }
compdef _r r

