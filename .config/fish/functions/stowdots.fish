function stowdots --description 'Restow dotfiles from ~/dotfiles'
    stow -R -d ~/dotfiles -t ~ . $argv
    and echo "✅ Dotfiles updated."
end