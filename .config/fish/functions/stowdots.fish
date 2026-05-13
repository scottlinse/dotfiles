function stowdots --description 'Restow dotfiles and sync to git'
    set -l do_push false
    set -l stow_args

    for arg in $argv
        if test "$arg" = "--push"
            set do_push true
        else
            set -a stow_args $arg
        end
    end

    stow -R -d ~/dotfiles -t ~ . $stow_args
    echo "✅ Dotfiles updated."

    if $do_push
        pushd ~/dotfiles
        git add -A
        if git diff --cached --quiet
            echo "ℹ️  No changes to commit."
        else
            git commit -m "Update "(date +%Y-%m-%d)
            git push
        end
        popd
    end
end
