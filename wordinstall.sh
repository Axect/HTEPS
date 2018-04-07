export DIRECTORY=$HOME/.local/lib/HTEPS

if [ ! -d "$DIRECTORY" ]; then
  mkdir -p ~/.local/lib/HTEPS
fi

cp -r ./WORDLIST/* ~/.local/lib/HTEPS/

