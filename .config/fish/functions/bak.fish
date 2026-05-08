function bak --description 'Backup a file with timestamp'
    cp -r $argv[1] $argv[1].bak.(date +%Y%m%d-%H%M%S)
end