
# FISH
set fish_greeting

set fish_color_autosuggestion    brblack
set fish_color_command           green   --bold
set fish_color_comment           brblack
set fish_color_cwd               brblack --bold
set fish_color_end               green
set fish_color_error             normal
set fish_color_escape            purple
set fish_color_param             green
set fish_color_quote             yellow
set fish_pager_color_prefix      yellow
set fish_pager_color_completion  white
set fish_pager_color_description purple


# EDITOR
set -x EDITOR vim


# ABBREVIATIONS
if status is-interactive
    abbr --add --global br brew
    abbr --add --global g git
    abbr --add --global v vim
end

# ENV
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-11.0.2.jdk/Contents/Home 

