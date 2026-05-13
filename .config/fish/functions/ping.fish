function ping --wraps=ping --description 'Pings 5 times by default'
    command ping -c 5 $argv
end