
function __sparkui_pod -a context namespace pod
    set -l description (kubectl --context $context -n $namespace describe pod $pod)
    set -l node (string join \n $description | grep -i "node:" | awk -F":" '{print $2}' | string trim | awk -F"/" '{print $1}')
    set -l port (string join \n $description | grep -Eio "spark.ui.port=\d+" | awk -F"=" '{print $2}')
    set -l tmux_session "spark_uis"
    set -l tmux_window $pod
    set -l local_port (random 60000 61000)
    echo "==========================================="
    echo "Forwarding: $pod"
    echo "kubectl --context $context -n $namespace port-forward $pod $local_port:$port"
    echo "http://localhost:$local_port"
    echo "==========================================="
    if ! tmux has-session -t $tmux_session 2> /dev/null
      tmux new-session -s $tmux_session -d
    end
    tmux new-window -t $tmux_session -n $tmux_window
    tmux send-keys -t $tmux_session:$tmux_window \
      "kubectl --context $context -n $namespace port-forward $pod $local_port:$port &" ENTER \
      "while ! nc -z localhost $local_port; echo Waiting for port; sleep 0.5; end" ENTER \
      "echo http://localhost:$local_port | xargs open" ENTER \
      "fg" ENTER
end
