export PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
export VISUAL=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
export ALTERNATE_EDITOR=emacs

# use zsh
if [ -f /bin/zsh ]; then
    exec /bin/zsh
fi

