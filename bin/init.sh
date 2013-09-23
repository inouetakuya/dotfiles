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
.git-flow-completion.zsh
.powconfig
.keysnail.js
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
  rm -f ~/${FILE}
  ln -sf ~/dotfiles/${FILE} ~/${FILE}
done

