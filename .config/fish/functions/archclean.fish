function archclean --description 'Remove orphaned packages'
    set orphans (pacman -Qtdq)
    if test -n "$orphans"
        sudo pacman -Rns $orphans $argv
    else
        echo "✅ No orphans found."
    end
end