# Gets list of **running** pods and uses fuzzy selection to get a result. It
# ignores the kube-system namespace and the Spark executors
#
# @param namespace The k8s namespace to get pods. Empty to get all namespaces
# @return 2 lines, first with the namespace and second with the name of the
#         selected pod
function pods -a namespace
    if [ -z $namespace ]
      kubectl get pods --all-namespaces | read --null pods_list
    else
      kubectl get pods -n $namespace | read --null pods_list
    end
    if test $status -eq 0
      echo $pods_list \
          | grep "Running" \
          | grep -v "-exec-" \
          | grep -v "kube-system" \
          | fzf \
          | read result
      if [ -z $namespace ]
        echo $result | awk '{ print $1 }' # Namespace
        echo $result | awk '{ print $2 }' # Pod
      else
        echo $namespace
        echo $result | awk '{ print $1 }' # Pod
      end
    else
      echo "Error getting pods" 1>&2
      return $status
    end
end
# Shows all the pods in a namespace and opens the spark UI of the selected one
# (fuzzy)
#
# @param namespace  The k8s namespace to get pods. Empty to get all namespaces
function sparkui -a namespace
    set -l pod_info (pods $namespace)
    set -l namespace_final $pod_info[1]
    set -l name $pod_info[2]
    set -l description (kubectl -n $namespace_final describe pod $name)
    set -l node (string join \n $description | grep -i "node:" | awk -F":" '{print $2}' | string trim | awk -F"/" '{print $1}')
    set -l port (string join \n $description | grep -Eio "spark.ui.port=\d+" | awk -F"=" '{print $2}')
    set -l local_port (random 9000 9999)
    kubectl -n $namespace port-forward $name $local_port:$port &
    echo "==========================================="
    echo "Forwarding: $name"
    echo "kubectl -n $namespace port-forward $name $local_port:$port"
    echo "http://localhost:$local_port"
    echo "==========================================="
    # Wait for port to be available
    while ! nc -z localhost $local_port
      echo "localhost:$local_port is not available YET"
      sleep 0.5
    end
    echo "http://localhost:$local_port" | xargs open
    fg
end
