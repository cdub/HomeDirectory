
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

test -r /sw/bin/init.sh && . /sw/bin/init.sh
