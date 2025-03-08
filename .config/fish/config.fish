fish_vi_key_bindings

source ~/.config/fish/functions/sparkui.fish
source ~/.config/fish/functions/__sparkui_pod.fish

starship init fish | source
navi widget fish | source

# Set Java version with temurin, e.g brew install --cask temurin@8 
function set-jdk
    set -l jdkversion $argv[1]
    set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/temurin-$jdkversion.jdk/Contents/Home
    set -gx PATH $PATH $JAVA_HOME/bin
    java -version
end

funcsave set-jdk

set -gx SBT_OPTS "-Xms1024M -Xmx8G -Xss4M -XX:MaxMetaspaceSize=2048M"
set -gx SYSTEM_VERSION_COMPAT 1
set -gx STARSHIP_CONFIG ~/.config/starship.toml
set -gx FZF_DEFAULT_COMMAND "fd --type f"

source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.fish
set -gx PATH $PATH ~/.asdf/shims
set -gx NAVI_PATH ~/.config/navi:/Users/konstantinoschaitas/.local/share/navi/cheats

function kk
    kubectl config use-context (kubectl config get-contexts -o 'name' | fzf)
end

alias vim=nvim
alias python3=python

# Created by `pipx` on 2024-01-17 11:47:42
set PATH $PATH /Users/konstantinoschaitas/.local/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/konstantinoschaitas/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/konstantinoschaitas/Downloads/google-cloud-sdk/path.fish.inc'; end
