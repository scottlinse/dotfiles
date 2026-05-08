function extract --description 'Extract any archive'
    if not test -e "$argv[1]"
        echo "File not found: $argv[1]"
        return 1
    end
    switch $argv[1]
        # tar + compression (must come before plain compression cases)
        case '*.tar.gz' '*.tgz';        tar -xzf $argv[1]
        case '*.tar.bz2' '*.tbz2';      tar -xjf $argv[1]
        case '*.tar.xz' '*.txz';        tar -xJf $argv[1]
        case '*.tar.zst';               tar --zstd -xf $argv[1]
        case '*.tar.lz4';               tar --lz4 -xf $argv[1]
        case '*.tar.lzma';              tar --lzma -xf $argv[1]
        case '*.tar';                   tar -xf $argv[1]
        # plain single-file compression
        case '*.xz';                    unxz -k $argv[1]
        case '*.bz2';                   bunzip2 -k $argv[1]
        case '*.gz';                    gunzip -k $argv[1]
        case '*.zst';                   unzstd -k $argv[1]
        case '*.lz4';                   lz4 -d $argv[1]
        case '*.Z';                     uncompress $argv[1]
        # multi-file archives
        case '*.zip';                   unzip $argv[1]
        case '*.7z';                    7z x $argv[1]
        case '*.rar';                   unrar x $argv[1]
        case '*';                       echo "Unknown archive: $argv[1]"; return 1
    end
end