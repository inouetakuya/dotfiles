#!/bin/sh

# git clone git://github.com/inouetakuya/dotfiles.git の後に実行し、
#   ホームディレクトリを dotfiles リポジトリの内容に置き換える

# TODO: あとで対象ファイルを追加する
FILES="
.bash_profile
.zshrc
.tmux.conf
"

if [ ! -e ~/archive ]; then
  mkdir ~/archive
fi

for FILE in ${FILES}
do
  # 通常のファイルのみアーカイブする
  if [[ -f ~/${FILE} && ! -h ~/${FILE} && ! -f ~/archive/${FILE} ]]; then
    echo ${FILE}
    cp ~/${FILE} ~/archive/${FILE}
  fi

  # TODO: シンボリックリンクを作成する
done

