# Created by newuser for 4.3.12


# ウノウラボ by Zynga Japan: zshはじめました。
# http://labs.unoh.net/2010/05/zsh.html

# PROMPT
PS1="[@${HOST%%.*} %1~]%(!.#.$) " # この辺は好み
RPROMPT="%T"                    # 右側に時間を表示する
setopt transient_rprompt        # 右側まで入力がきたら時間を消す
setopt prompt_subst             # 便利なプロント
bindkey -e                      # emacs ライクなキーバインド

export LANG=ja_JP.UTF-8         # 日本語環境
export EDITOR=emacs             # エディタは emacs

autoload -U compinit            # 強力な補完機能
compinit -u                     # このあたりを使わないと zsh 使ってる意味なし
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

