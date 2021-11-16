#sh ~/.config/ufetch.sh
if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source  
    function fish_greeting
    
end
end
