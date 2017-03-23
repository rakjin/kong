# sorin-kong.zsh-theme

MODE_INDICATOR="%{$fg_bold[red]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"

function retcode() {}
make_prompt () {
    local darkgray='%{$FG[235]%}'
    local cyan='%{$fg[cyan]%}'
    local reset='%{$reset_color%}'

    local time_last=''
    time_last+=${darkgray}
    time_last+=$(date '+%Y-%m-%d %H:%M:%S')

    local return_code=''
    return_code+=${darkgray}'['
    return_code+='%(?.%{$fg[green]%}.%{$fg[magenta]%})%?'
    return_code+=${darkgray}']'

    local time_current=''
    time_current+=${darkgray}
    time_current+='%D{%Y-%m-%d %H:%M:%S}'

    local cwd=''
    cwd+=${cyan}
    cwd+='%c'

    PROMPT=''
    PROMPT+=${time_last}
    PROMPT+=' '
    PROMPT+=${return_code}
    PROMPT+=$'\n'
    PROMPT+=${time_current}
    PROMPT+=' '
    PROMPT+=${cwd}
    PROMPT+='$(git_prompt_info)'
    PROMPT+=' '
    PROMPT+='%(!.%{$fg_bold[red]%}###.%{$fg_bold[green]%}❯❯❯)'
    PROMPT+=${reset}
    PROMPT+=' '
}
make_prompt

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}git%{$reset_color%}:%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

RPROMPT='$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"


TMOUT=13  # 1초마다 하니까 터미널 여러개 띄우면 빡세다
TRAPALRM() {
    zle reset-prompt
}

preexec () { make_prompt }
