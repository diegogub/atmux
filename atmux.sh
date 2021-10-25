#!/bin/bash

TMUX_DIR="~/"

#tmux_set_tmux_dir cofigures internal tmux starting dir for session
tmux_set_tmux_dir(){
    TMUX_DIR=$1
}

tmux_session_exist(){
    if tmux has-session -t $1 2>/dev/null
    then
        return 1
    else
        return 0
    fi
}

# tmux_new_window  session-name first-window
tmux_new_session(){
    tmux_session_exist $1
    if [ $? -eq 0 ]
    then
        tmux new -d -c $TMUX_DIR -s $1
        if [ "$2" = "" ]
        then
            tmux rename-window -t $1:1 $1
        else
            tmux rename-window -t $1:1 $2
        fi
    else
        return 1
    fi
}

# tmux_new_window  session-name window-name
tmux_new_window(){
    exist=$(tmux list-windows -t $1 | grep $2)
    if [ "$exist" = "" ]
    then
        tmux new-window -d -a -c $TMUX_DIR -t $1 -n $2 
    else
        return 1
    fi
}

tmux_send_keys(){
    local target=$1
    tmux send-keys -t$target -l "$2"
    tmux send-keys -t$target Enter
}

tmux_kill_session(){
    tmux kill-session -t $1
}

tmux_split_window(){
    if [ "$2" = "" ]
    then
        tmux split-window -t$1 
    else
        tmux split-window -t$1 -p$2
    fi
}

tmux_split_window_vertical(){
    if [ "$2" = "" ]
    then
        tmux split-window -t$1 -h 
    else
        tmux split-window -t$1 -h -p $2
    fi
}
