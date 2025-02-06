function fish_greeting
    echo hello, $(whoami)@$(hostname), the time is now $(date +%H:%M:%S)
end
