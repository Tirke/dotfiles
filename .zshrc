
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-rust \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-bin-gem-node

### End of Zinit's installer chunk

fpath+=( /usr/local/share/zsh/site-functions /opt/homebrew/share/zsh/site-functions )
path+=( $HOME/go/bin $HOME/.cargo/bin $HOME/.yarn/bin )

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
        export AWS_DEFAULT_REGION=eu-central-1
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
    zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    atload'bindkey "^[[A" history-substring-search-up;
        bindkey "^[[B" history-substring-search-down' \
    zsh-users/zsh-history-substring-search \
    zdharma-continuum/history-search-multi-word \
    blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

