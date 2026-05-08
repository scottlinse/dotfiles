function ll --wraps='eza -l --color=always --group-directories-first' --description 'alias ll=eza -l --color=always --group-directories-first'
    eza -l --color=always --group-directories-first $argv
end
