proxy_host="localhost"
proxy_port="7890"

function setproxy() {
    export all_proxy="http://$proxy_host:$proxy_port"
    export http_proxy="http://$proxy_host:$proxy_port"
    export https_proxy="http://$proxy_host:$proxy_port"
    export NO_PROXY=localhost,::1,.example.com
}
function unsetproxy() {
    export all_proxy=""
    export http_proxy=""
    export https_proxy=""
}
