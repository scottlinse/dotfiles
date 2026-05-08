function archgc --wraps='sudo pacman -Sc' --description 'alias archgc=sudo pacman -Sc'
    sudo pacman -Sc $argv
end
