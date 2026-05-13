if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/scott/.lmstudio/bin
# End of LM Studio CLI section

# Initialize zoxide in place of cd
zoxide init --cmd cd fish | source