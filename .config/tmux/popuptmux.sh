if [ "$(tmux display-message -p -F "#{session_name}")" = "popup" ];then
    tmux detach-client
else
    tmux popup -h 85% -w 90% -b rounded -E "tmux attach -t popup || tmux new -s popup"
fi
