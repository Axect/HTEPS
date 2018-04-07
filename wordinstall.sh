export DIRECTORY=$HOME/.local/lib/HTEPS

if [ ! -d "$DIRECTORY" ]; then
  mkdir -p ~/.local/lib/HTEPS
fi

git pull

cp -r ./WORDLIST/* ~/.local/lib/HTEPS/

