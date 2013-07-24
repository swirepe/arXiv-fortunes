## ----------------------------------------------------------------------------
## set up error checking
## ----------------------------------------------------------------------------
# fail on any errors (same as set -e)
set -o errexit

COLOR_BPurple='\033[1;35m'
COLOR_Red='\033[0;31m'
COLOR_off='\033[0m'



function error() {
    JOB="$0"              # job name
    LASTLINE="$1"         # line of error occurrence
    LASTERR="$2"          # error code
    echo -e "${COLOR_Red}ERROR in ${JOB} : line ${LASTLINE} with exit code ${LASTERR}: $(sed -n ${LASTLINE}p $THIS_SCRIPT_PATH) ${COLOR_off}"
    exit 1
}
trap 'error ${LINENO} ${$?}' ERR


## ----------------------------------------------------------------------------
## check dependencies
## ----------------------------------------------------------------------------


echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Checking for necessary programs."
which bc
which date
which fortune
which git
which python
which sed
which strfile
which unxz



_START_TIME=$(date +%s)
echo -e 
echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Cloning arxiv repository. (This can take a long time.)"
pushd . > /dev/null
git clone --depth 1 git://github.com/swirepe/arXiv-fortunes.git ~/.arxiv
cd ~/.arxiv

unxz arxiv_fortunes.txt.xz
echo -e  "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Current space used: $(du -hc | tail -1)"

echo -e  "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Generating a sample of 1000 fortunes, as to save disk space."

python sample.py
strfile *.txt


echo -e  "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Now removing the things you don't need."
rm -v arxiv.tar.xz
rm -v getArxiv.py
rm -v parseArxiv.py
rm -v arxiv_fortunes.txt
rm -v arxiv_fortunes.txt.dat
rm -v get.sh
rm -v getShort.sh
rm -v sample.py
rm -v -rf .git
rm -v -rf arxiv-pyenv


echo -e "\n\n[GENERATED WITH getShort.sh :: curl -L https://raw.github.com/swirepe/arXiv-fortunes/master/getShort.sh | bash]" >> README.md 

echo -e  "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Current space used: $(du -hc | tail -1)"



echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} This is a fortune:"
fortune .



popd > /dev/null

echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Done."
_END_TIME=$(date +%s)
echo -e "${COLOR_BPurple}[arxiv-fortune]${COLOR_off} Finished in $(echo -e "$_END_TIME - $_START_TIME" | bc -l ) seconds."
 
