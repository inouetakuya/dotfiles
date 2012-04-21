# Created by newuser for 4.3.12


# ホストごとの設定
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
rad-xen-vweb2)
    export RUBYLIB=/home/sites/h300:$RUBYLIB
    ;;
rad-xen-vweb4)
    export RUBYLIB=/home/sites/h300:$RUBYLIB
    ;;
esac


# 漢のzsh (1) 最強のシェル、それは「zsh」 | エンタープライズ | マイナビニュース
# http://news.mynavi.jp/column/zsh/001/index.html
autoload -U compinit            # 補完機能
compinit


# 漢のzsh (2) 取りあえず、プロンプトを整えておく。カッコつけたいからね | エンタープライズ | マイナビニュース
# http://news.mynavi.jp/column/zsh/002/index.html
export LANG=ja_JP.UTF-8         # 日本語環境
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


# 漢のzsh (5) 「あーっ!」というそのときのために - 備えあれば憂いなしの設定集 | エンタープライズ | マイナビニュース
# http://news.mynavi.jp/column/zsh/005/index.html
setopt auto_cd                  # ディレクトリ名で cd できる
setopt auto_pushd               # 移動したディレクトリを記録しておく
setopt correct                  # コマンド名が間違っている場合には修正
setopt list_packed              # リストを詰めて表示
setopt nolistbeep               # 補完候補表示時などにビープ音を鳴らさない


# 漢のzsh (24) グッバイ野郎ども! コピペではじめるzshファイナル | エンタープライズ | マイナビニュース
# http://news.mynavi.jp/column/zsh/024/index.html
alias la="ls -a"
alias ll="ls -l"


# ウノウラボ by Zynga Japan: zshはじめました。
# http://labs.unoh.net/2010/05/zsh.html

# PROMPT
PS1="[@${HOST%%.*} %1~]%(!.#.$) " # この辺は好み
setopt transient_rprompt        # 右側まで入力がきたら時間を消す
setopt prompt_subst             # 便利なプロント


export EDITOR=emacs             # エディタは emacs

setopt pushd_ignore_dups        # 同ディレクトリを履歴に追加しない
setopt list_types               # 補完一覧ファイル種別表示


# 履歴
setopt hist_reduce_blanks       # スペース排除
setopt EXTENDED_HISTORY         # zsh の開始終了を記録


# alias
alias ls="ls -G"
alias be="bundle exec"
alias av="git commit -av"
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'


[ -f ~/.zshrc.include ] && source ~/.zshrc.include # 設定ファイルの include

zstyle ':completion:*:default' menu select=1 # ファイル名の候補を C-f / C-b などでカーソル選択できる


