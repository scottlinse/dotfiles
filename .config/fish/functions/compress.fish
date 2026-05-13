function compress --description 'Create an archive at max compression'
    if test (count $argv) -eq 0
        echo "Usage: compress <files...> [output|.ext]"
        echo "  Default format: .7z"
        echo "  Pass '.tar.zst' (etc.) to keep input name with a different format"
        return 1
    end

    set -l inputs $argv
    set -l out

    # If the last arg doesn't exist on disk, treat it as an output spec
    set -l last $argv[-1]
    if not test -e "$last"
        if string match -rq '^\.' -- $last
            # Extension-only override: reuse first input's basename
            set out (basename $inputs[1])$last
            set inputs $inputs[1..-2]
        else if test (count $argv) -gt 1
            # Full output filename
            set out $last
            set inputs $inputs[1..-2]
        end
    end

    if test (count $inputs) -eq 0
        echo "No input files specified"
        return 1
    end

    for f in $inputs
        if not test -e "$f"
            echo "File not found: $f"
            return 1
        end
    end

    test -z "$out"; and set out (basename $inputs[1])".7z"

    if test -e "$out"
        echo "Output already exists: $out"
        return 1
    end

    set -l compressor
    switch (string lower $out)
        case '*.tar.gz' '*.tgz';     set compressor 'gzip -9'
        case '*.tar.bz2' '*.tbz2';   set compressor 'bzip2 -9'
        case '*.tar.xz' '*.txz';     set compressor 'xz -9 -e -T0'
        case '*.tar.zst';            set compressor 'zstd --ultra -22 --long=31 -T0'
        case '*.tar.lz4';            set compressor 'lz4 -12'
        case '*.tar.lzma';           set compressor 'lzma -9 -e'
        case '*.tar';                set compressor 'cat'
        case '*.tar.lrz';            lrztar -z -L 9 -o $out $inputs[1]; return
        case '*.zip';                zip -9 -r $out $inputs;            return
        case '*.7z';                 7z a -mx=9 -m0=lzma2:d1024m -mfb=273 -ms=on $out $inputs; return
        case '*.zpaq';               zpaq a $out $inputs -m5;           return
        case '*';                    echo "Unknown archive format: $out"; return 1
    end

    if command -q pv
        set -l total (du -csb $inputs | tail -n1 | cut -f1)
        tar -cf - $inputs | pv -s $total | eval $compressor > $out
    else
        tar -I "$compressor" -cvf $out $inputs
    end
end