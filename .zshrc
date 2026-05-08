# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/scott/.zshrc'

# Path for scripts
# export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:~/.local/bin

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Starship
# eval "$(starship init zsh)"

alias -- ..='cd ..'
alias -- ...='cd ../..'
alias -- btw='echo i use arch btw'
alias -- calc=gnome-calculator
alias -- calculator=gnome-calculator
alias -- ff=fastfetch
alias -- g=git
alias -- gcalc=gnome-calculator
alias -- gedit=gnome-text-editor
alias -- htop=btop
alias -- l='ls -lFh'
alias -- la='ls -lAFh'
alias -- ll='ls -la'
alias -- lr='ls -tRFh'
alias -- lt='ls -ltFh'
alias -- neofetch=fastfetch
alias -- nf=fastfetch
alias -- yay=paru
alias -- paclean='orphans=$(pacman -Qtdq); [ -n "$orphans" ] && sudo pacman -Rns $orphans || echo "✅ No orphans found."'
alias -- pacclean='orphans=$(pacman -Qtdq); [ -n "$orphans" ] && sudo pacman -Rns $orphans || echo "✅ No orphans found."'
alias -- pacgc='sudo pacman -Sc'
alias -- stowdots='stow -R -d ~/dotfiles -t ~ . && echo "✅ Dotfiles updated."'

exec fish
# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/scott/.lmstudio/bin"
# End of LM Studio CLI section

