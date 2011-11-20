# Created by newuser for 4.3.12


# 漢のzsh (1) 最強のシェル、それは「zsh」
# http://news.mynavi.jp/column/zsh/001/index.html
autoload -U compinit            # 補完機能
compinit


# 漢のzsh (2) 取りあえず、プロンプトを整えておく。カッコつけたいからね
# http://news.mynavi.jp/column/zsh/002/index.html
case ${UID} in
0)
    PROMPT="%B%{[31m%}%/#%{[m%}%b " # 通常のプロンプト
    PROMPT2="%B%{[31m%}%_#%{[m%}%b " # for や while 複数行入力時に表示されるプロンプト
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b " # 入力ミスを確認する場合に表示されるプロンプト
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[31m%}%/%%%{[m%} "
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac 

# ターミナルのタイトル
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac


# ウノウラボ by Zynga Japan: zshはじめました。
# http://labs.unoh.net/2010/05/zsh.html

# PROMPT
PS1="[@${HOST%%.*} %1~]%(!.#.$) " # この辺は好み
setopt transient_rprompt        # 右側まで入力がきたら時間を消す
setopt prompt_subst             # 便利なプロント
bindkey -e                      # emacs ライクなキーバインド

export LANG=ja_JP.UTF-8         # 日本語環境
export EDITOR=emacs             # エディタは emacs

setopt autopushd                # cd の履歴を表示
setopt pushd_ignore_dups        # 同ディレクトリを履歴に追加しない
setopt auto_cd                  # 自動的にディレクトリ移動
setopt list_packed              # リストを詰めて表示
setopt list_types               # 補完一覧ファイル種別表示


# 履歴
HISTFILE=~/.zsh_history         # history ファイル
HISTSIZE=10000                  # ファイルサイズ
SAVEHIST=10000                  # save する量
setopt hist_ignore_dups         # 重複を記録しない
setopt hist_reduce_blanks       # スペース排除
setopt share_history            # 履歴ファイルを共有
setopt EXTENDED_HISTORY         # zsh の開始終了を記録


# history 操作まわり
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


# alias
alias ls="ls -G"
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'


[ -f ~/.zshrc.include ] && source ~/.zshrc.include # 設定ファイルの include

zstyle ':completion:*:default' menu select=1 # ファイル名の候補を C-f / C-b などでカーソル選択できる