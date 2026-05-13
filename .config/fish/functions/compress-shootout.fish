function compress-shootout --description 'Compress to .tar.zst, .tar.lrz, and .7z; report smallest'
    if test (count $argv) -eq 0
        echo "Usage: compress-shootout <files...>"
        return 1
    end
    for f in $argv
        if not test -e "$f"
            echo "File not found: $f"
            return 1
        end
    end

    set -l base (basename $argv[1])
    set -l formats .tar.zst .tar.lrz .7z
    set -l outs

    for fmt in $formats
        set -l out $base$fmt
        set -a outs $out
        if test -e "$out"
            echo "Skipping: $out already exists"
            continue
        end
        echo
        echo "=== Compressing to $out ==="
        compress $argv $fmt
    end

    set -l input_size (du -csb $argv | tail -n1 | cut -f1)
    echo
    echo "=== Results (smallest first) ==="
    printf "Input size: %s\n\n" (numfmt --to=iec $input_size)
    for out in $outs
        test -e "$out"; or continue
        set -l bytes (du -b $out | cut -f1)
        set -l ratio (math --scale=1 "$bytes / $input_size * 100")
        printf "%s\t%s\t%s%%\n" $bytes $out "$ratio"
    end | sort -n | while read -l bytes name pct
        printf "  %-30s %10s   %s of input\n" $name (numfmt --to=iec $bytes) $pct
    end
end