#!/bin/fish
set -g TMUX_DIR "~/"

function atmux_start --description "start default session if does not exist"
    tmux new-session -tdefault -ndefault 2>/dev/null
end
funcsave atmux_start

function atmux_set_dir --description "define starting dir for tmux session"
    set TMUX_DIR $argv[1]
end
funcsave atmux_set_dir

function atmux_session_exist --description "check if session exist"
    if tmux has-session -t $argv[1] 2>/dev/null
        return 1
    else
        return 0
    end 
end
funcsave atmux_session_exist

function atmux_new_session --description "creates new session"
    atmux_session_exist $argv[1]
    if test "$status" -eq 1
        return 0 
    else
        tmux new-session -d -c $TMUX_DIR -s$argv[1] -n$argv[2]
    end
end
funcsave atmux_new_session


function atmux_kill_session --description "kills session"
    tmux kill-session -t $argv[1]
end
funcsave atmux_kill_session

function atmux_new_window --description "creates new window"
    tmux new-window -d -a -c $TMUX_DIR -t $argv[1] -n $argv[2]
end
funcsave atmux_new_window

function atmux_split_window --description "split windows by %"
    tmux split-window -t$argv[1] -p$argv[2]
end
funcsave atmux_split_window

function atmux_send_keys --description "sends commands to window"
    tmux send-keys -t $argv[1] $argv[2..]
end
funcsave atmux_send_keys



