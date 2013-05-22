COLOR_BPurple='\033[1;35m'
COLOR_off='\033[0m'

_START_TIME=$(date +%s)
echo -e 
echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Cloning arxiv repository."
pushd . > /dev/null
git clone git://github.com/swirepe/arXiv-fortunes.git ~/.arxiv
cd ~/.arxiv

echo -e  "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Now removing the things you don't need."
rm arxiv.tar.xz
rm  getArxiv.py
rm parseArxiv.py
unxz arxiv_fortunes.txt.xz

echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} This is a fortune:"
fortune .


echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Adding the fortune command to your shellrc"

RANDOM_FORTUNE_STR='
## display a random paper from arxiv.org
## https://github.com/swirepe/arXiv-fortunes
if [ $[ ( $RANDOM % 100 ) ] -lt  40 ]
then
    fortune ~/.arxiv
fi'

SHELL_NAME=$(basename "$SHELL")

if [[ "$SHELL_NAME" == "bash" && -f ~/.bashrc]] 
then
    echo "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Adding to ~/.bashrc"
    echo  "$RANDOM_FORTUNE_STR" >> ~/.bashrc
elif [[ "$SHELL_NAME" == "zsh" ]]
then
    echo "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Adding to ~/.zshrc"
    echo  "$RANDOM_FORTUNE_STR" >> ~/.zshrc
else
    echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Not sure what shell you are using..."
    GUESS_RC="~/.${SHELL_NAME}rc"
    echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Adding fortune to $GUESS_RC"
    echo -e "$RANDOM_FORTUNE_STR" >> $GUESS_RC
fi

popd > /dev/null

echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Done."
_END_TIME=$(date +%s)
echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Finished in $(echo -e "$_END_TIME - $_START_TIME" | bc -l ) seconds."
 
