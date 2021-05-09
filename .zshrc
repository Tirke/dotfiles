
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

fpath+=( /usr/local/share/zsh/site-functions )
path+=( $HOME/go/bin $HOME/.cargo/bin /usr/local/opt/node@12/bin )

zinit lucid for \
    atinit"HIST_STAMPS=dd.mm.yyyy" \
    OMZL::history.zsh \
    light-mode pick"async.zsh" src"pure.zsh" \
                sindresorhus/pure

zinit wait lucid for \
    OMZL::completion.zsh \
    atload"
        alias ..='cd ..'
        alias ...='cd ../..'
        alias ....='cd ../../..'
        alias .....='cd ../../../..'
        alias l='ls -lahG'
        alias tf='terraform'    
        export LSCOLORS='Exfxcxdxbxegedabagacad'
        eval '$(fnm env)'
    " \
    OMZL::directories.zsh \
	OMZL::git.zsh \
    OMZP::brew \
    OMZP::git \
    OMZL::spectrum.zsh \
	OMZL::termsupport.zsh \
    agkozak/zsh-z \

zinit wait lucid for \
    atinit"zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    atload'bindkey "^[[A" history-substring-search-up;
        bindkey "^[[B" history-substring-search-down' \
    zsh-users/zsh-history-substring-search \
    zdharma/history-search-multi-word \
    blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

zinit wait lucid for \
 has'az' \
 as'null' \
 id-as'az_completion' \
 mv'az_completion -> _az' \
 atload'autoload -Uz bashcompinit && bashcompinit && source _az' \
    https://github.com/Azure/azure-cli/blob/dev/az.completion



test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
