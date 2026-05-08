function .. --description 'cd up N levels (default 1)'
    set -l n 1
    test -n "$argv[1]"; and set n $argv[1]
    cd (string repeat -n $n '../' | string trim -r -c /)
end