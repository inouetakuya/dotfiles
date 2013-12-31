#!/bin/sh

# git clone git://github.com/inouetakuya/dotfiles.git の後に実行し、
#   ホームディレクトリを dotfiles リポジトリの内容に置き換える
FILES="
.bash_profile
.zshrc
.tmux.conf
.tmuxinator
.gitconfig
.gitignore
.powconfig
.keysnail.js
Gemfile
Gemfile.lock
"

if [ ! -e ~/archive ]; then
  mkdir ~/archive
fi

for FILE in ${FILES}
do
  # 通常のファイルのみアーカイブする
  if [[ -f ~/${FILE} && ! -h ~/${FILE} && ! -f ~/archive/${FILE} ]]; then
    echo "cp -ap ~/${FILE} ~/archive/${FILE}"
    cp -ap ~/${FILE} ~/archive/${FILE}
  fi

  # シンボリックリンクを作成する
  rm ~/${FILE}
  ln -s ~/dotfiles/${FILE} ~/${FILE}
done

