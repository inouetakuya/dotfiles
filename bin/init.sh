#!/bin/sh

# git clone git://github.com/inouetakuya/dotfiles.git の後に実行し、
#   ホームディレクトリを dotfiles リポジトリの内容に置き換える

# TODO: あとで対象ファイルを追加する
FILES="
.bash_profile
.zshrc
.zshenv
.tmux.conf
"

if [ ! -e ~/archive ]; then
  mkdir ~/archive
fi

for FILE in ${FILES}
do
  # アーカイブする
  if [ ! -e ~/archive/${FILE} ]; then
    cp ~/${FILE} ~/archive/${FILE}
  fi

  # TODO: シンボリックを作成する
done

