function stowdots --description 'Restow dotfiles and sync to git'
    stow -R -d ~/dotfiles -t ~ . $argv
    echo "✅ Dotfiles updated."
    
    if test "$argv[1]" = "--push"
        pushd ~/dotfiles
        git add -A
        git commit -m "Update "(date +%Y-%m-%d)
        git push
        popd
    end
end