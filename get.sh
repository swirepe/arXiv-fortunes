
_START_TIME=$(date +%s)

echo "Cloning arxiv repository."
pushd .
git clone git://github.com/swirepe/arXiv-fortunes.git ~/.arxiv
cd ~/.arxiv

echo  "Now removing the things you don't need."
rm -i arxiv.tar.xz
rm -i getArxiv.py
rm -i parseArxiv.py
unxz arxiv_fortunes.txt.xz

echo "This is a fortune:"
fortune .


echo "Adding the fortune command to your shellrc"

RANDOM_FORTUNE_STR='
# display a random paper from arxiv.org
if [ $[ ( $RANDOM % 100 ) ] -lt  40 ]
then
    fortune ~/.arxiv
fi'

SHELL_NAME=$(basename "$SHELL")

if [[ "$SHELL_NAME" == "bash" ]] 
then
    echo "$RANDOM_FORTUNE_STR" >> ~/.bashrc
elif [[ "$SHELL_NAME" == "zsh" ]]
then
    echo "$RANDOM_FORTUNE_STR" >> ~/.zshrc
else
    echo "Not sure what shell you are using..."
    GUESS_RC="~/.${SHELL_NAME}rc"
    echo "Putting the random fortune in $GUESS_RC"
    echo "$RANDOM_FORTUNE_STR" >> $GUESS_RC
fi

echo "Done."
_END_TIME=$(date +%s)
echo "Finished in $(echo "$_END_TIME - $_START_TIME" | bc -l ) seconds."
 
