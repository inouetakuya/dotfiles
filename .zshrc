# Created by newuser for 4.3.12

#=======================================
# ホストごとの設定
#=======================================
case ${HOST} in
ANGELINA.local)
    export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
    export PATH=/usr/local/Cellar/ruby/1.9.2-p290/bin:$PATH
    export RUBYLIB=$HOME/Dropbox/Projects/twenty-eight/h300:$RUBYLIB
    export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
    export VISUAL=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
    export ALTERNATE_EDITOR=emacs
    ;;
MATHILDA.local)
    export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
    export PATH=/usr/local/Cellar/ruby/1.9.2-p290/bin:$PATH
    export RUBYLIB=$HOME/Dropbox/Projects/twenty-eight/h300:$RUBYLIB
    export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
    export VISUAL=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
    export ALTERNATE_EDITOR=emacs
    ;;
esac

case ${HOSTNAME} in
rad-xen-vweb1)
    export RUBYLIB=/home/sites/h300:$RUBYLIB
    ;;
rad-xen-vweb2)
    export RUBYLIB=/home/sites/h300:$RUBYLIB
    ;;
rad-xen-vweb4)
    export RUBYLIB=/home/sites/h300:$RUBYLIB
    ;;
rad-xen-vweb6)
    export RUBYLIB=/home/sites/h300:$RUBYLIB
    ;;
esac


#=======================================
# 基本設定
#=======================================
# 漢のzsh (1) 最強のシェル、それは「zsh」 | エンタープライズ | マイナビニュース
# http://news.mynavi.jp/column/zsh/001/index.html
autoload -U compinit            # 補完機能
compinit

export LANG=ja_JP.UTF-8         # 日本語環境
export EDITOR=emacs             # エディタは emacs


#=======================================
# プロンプト
#=======================================
# dotfiles/.zshrc at master · glidenote/dotfiles · GitHub
# https://github.com/glidenote/dotfiles/blob/master/.zshrc
autoload colors
colors


autoload -Uz is-at-least

# Git のカレントブランチ、状態を表示させる
if is-at-least 4.3.10; then
    # http://d.hatena.ne.jp/uasi/20091025/1256458798
    autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

    function rprompt-git-current-branch {
    local name st color gitdir action
    if [[ "$PWD" == '/\.git(/.*)?$' ]]; then
        return
    fi
    name=`git branch 2> /dev/null | grep '^\*' | cut -b 3-`
    if [[ -z $name ]]; then
        return
    fi

    gitdir=`git rev-parse --git-dir 2> /dev/null`
    action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        color=%F{green}
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
        color=%F{yellow}
    elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
        color=%B%F{red}
    else
        color=%F{red}
    fi

    echo "$color$name$action%f%b"
    }

    # プロンプトが表示されるたびにプロンプト文字列を評価、置換する
    setopt prompt_subst
    RPROMPT='%{${fg[cyan]}%}[`rprompt-git-current-branch`%{${fg[green]}%}][%~]%{${reset_color}%}'

else
    RPROMPT="%{${fg[green]}%}[%~]%{${reset_color}%}"
fi

PROMPT="[%n%{${fg[green]}%}@%m%{${reset_color}%}]${WINDOW:+"[$WINDOW]"}%(!.#.$) "
PROMPT2="%{${fg[green]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"

# # 漢のzsh (2) 取りあえず、プロンプトを整えておく。カッコつけたいからね | エンタープライズ | マイナビニュース
# # http://news.mynavi.jp/column/zsh/002/index.html
# case ${UID} in
# 0)  # root のとき
#     # PROMPT="%B%{[31m%}%/#%{[m%}%b " # 通常のプロンプト
#     PROMPT="%B%{[31m%}[${USER}@${HOST%%.*} %1~]%(!.#.$) "
#     PROMPT2="%B%{[31m%}%_#%{[m%}%b " # for や while 複数行入力時に表示されるプロンプト
#     SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b " # 入力ミスを確認する場合に表示されるプロンプト
#     [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#         PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
#     ;;
# *)  # root 以外のとき
#     # PROMPT="%{[31m%}%/%%%{[m%} "
#     PROMPT="%{[31m%}[${USER}@${HOST%%.*} %1~]%(!.#.$) "
#     PROMPT2="%{[31m%}%_%%%{[m%} "
#     SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
#     [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#         PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
#     ;;
# esac 

# ターミナルのタイトル
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac


#=======================================
# 履歴
#=======================================
# 漢のzsh (3) 同じことを2度するなんて…… 自分の過去は利用しましょう | エンタープライズ | マイナビニュース
# http://news.mynavi.jp/column/zsh/003/index.html
HISTFILE=~/.zsh_history         # history ファイル
HISTSIZE=10000                  # ファイルサイズ
SAVEHIST=10000                  # save する量
setopt hist_ignore_dups         # 重複を記録しない
setopt share_history            # 履歴ファイルを共有


# 漢のzsh (4) コマンド履歴の検索～EmacsとVi、どっちも設定できるぜzsh | エンタープライズ | マイナビニュース
# http://news.mynavi.jp/column/zsh/004/index.html
bindkey -e                      # emacs ライクなキーバインド

# 履歴検索機能のショートカット設定
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt pushd_ignore_dups        # 同ディレクトリを履歴に追加しない
setopt hist_reduce_blanks       # スペース排除
setopt EXTENDED_HISTORY         # zsh の開始終了を記録


#=======================================
# オプション
#=======================================
# 漢のzsh (5) 「あーっ!」というそのときのために - 備えあれば憂いなしの設定集 | エンタープライズ | マイナビニュース
# http://news.mynavi.jp/column/zsh/005/index.html
setopt auto_cd                  # ディレクトリ名で cd できる
setopt auto_pushd               # 移動したディレクトリを記録しておく
setopt correct                  # コマンド名が間違っている場合には修正
setopt list_packed              # リストを詰めて表示
setopt nolistbeep               # 補完候補表示時などにビープ音を鳴らさない

# ウノウラボ by Zynga Japan: zshはじめました。
# http://labs.unoh.net/2010/05/zsh.html
setopt transient_rprompt        # 右側まで入力がきたら時間を消す
setopt prompt_subst             # 便利なプロント
setopt list_types               # 補完一覧ファイル種別表示

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' menu select=1 # ファイル名の候補を C-f / C-b などでカーソル選択できる


#=======================================
# エイリアス
#=======================================
# 漢のzsh (24) グッバイ野郎ども! コピペではじめるzshファイナル | エンタープライズ | マイナビニュース
# http://news.mynavi.jp/column/zsh/024/index.html
alias la="ls -a"
alias ll="ls -l"

alias ls="ls -G"
alias be="bundle exec"
alias av="git commit -av"


#=======================================
# その他
#=======================================
[ -f ~/.zshrc.include ] && source ~/.zshrc.include # 設定ファイルの include


