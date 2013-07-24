COLOR_BPurple='\033[1;35m'
COLOR_off='\033[0m'

_START_TIME=$(date +%s)
echo -e 
echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Cloning arxiv repository."
pushd . > /dev/null
git clone --depth 1 git://github.com/swirepe/arXiv-fortunes.git ~/.arxiv
cd ~/.arxiv

unxz arxiv_fortunes.txt.xz
echo -e  "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Current space used: $(du -hc | tail -1)"

echo -e  "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Generating a sample of 1000 fortunes, as to save disk space."

python sample.py
strfile *.txt


echo -e  "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Now removing the things you don't need."
rm arxiv.tar.xz
rm getArxiv.py
rm parseArxiv.py
rm arxiv_fortunes.txt
rm arxiv_fortunes.txt.dat
rm get.sh
rm getShort.sh
rm sample.py
rm -rf .git
rm -rf arxiv-pyenv


echo -e "\n\n[GENERATED WITH getShort.sh :: curl -L https://raw.github.com/swirepe/arXiv-fortunes/master/getShort.sh | bash]" >> README.md 

echo -e  "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Current space used: $(du -hc | tail -1)"



echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} This is a fortune:"
fortune .



popd > /dev/null

echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Done."
_END_TIME=$(date +%s)
echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Finished in $(echo -e "$_END_TIME - $_START_TIME" | bc -l ) seconds."
 
