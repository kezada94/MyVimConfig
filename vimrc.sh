VIMRC_LOCATION="$HOME"
VIMRC=".vimrc"
VIMRC_FILE="${VIMRC_LOCATION}/${VIMRC}"
PLUGINS_DIR="./plugins"
command -v git >/dev/null 2>&1 || { echo >&2 "git is not installed.  Aborting."; exit 1; }

### POWERLINE FONTS
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts


### VUNDLE
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
if ! test -f "$VIMRC_FILE"; then
	>"$VIMRC_FILE"
fi
tmp="$(mktemp)" && cat vundle.vrc "$VIMRC_FILE" >"$tmp" && mv "$tmp" "$VIMRC_FILE"
vim +PluginInstall +qall 

### VUNDLE
## copy vrc to vimrcs
for file in $PLUGINS_DIR/*.vrc; do
	echo $file
	cat "$file" >> "$VIMRC_FILE"
done
vim +PluginInstall +qall
