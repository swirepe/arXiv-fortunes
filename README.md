# arXiv Fortunes

Peter Swire - swirepe.com


----
    curl -L https://raw.github.com/swirepe/arXiv-fortunes/master/get.sh | bash
----


## What is it?

You know that `fortune` program?  It's pretty much my favorite.  I usually have it deliver me quotes from Star Trek or something, I think I found something even better.

This repository contains all of the titles and urls of papers hosted on [arXiv.org](http://www.arxiv.org), neatly arranged and ready to be displayed.  If you are feeling particularly data-futzy and don't want to wait a day to scrape the data yourself, you also get access to all of the metadata for all of the papers on that site.

## How do I use it?

All you really need is the `arxiv_fortunes.txt` file and the `arxiv_fortunes.txt.dat` file to be in the same directory. Then tell fortune to do it's thing.  You don't actually need any of the other files, but they are nice to have if you want to do your own project with them.  That's a lot of metadata going to waste if you don't.

    git clone git@github.com:swirepe/arXiv-fortunes.git ~/.arxiv
    cd ~/.arxiv
    echo  "Now removing the things you don't need."
    rm -i arxiv.tar.xz
    rm -i getArxiv.py
    rm -i parseArxiv.py
    unxz arxiv_fortunes.txt.xz
    fortune .

Then add this to your .bashrc, to have a fortune show up on new shell creation.


    if [ $[ ( $RANDOM % 100 ) ] -lt  40 ]
    then
        fortune ~/.arxiv
    fi


[That will display a fortune 40% of the time.](https://en.wikipedia.org/wiki/Reinforcement#Intermittent_reinforcements)  As it stands, those fortunes come out in color.

## Examples

    [ math ]
    http://arxiv.org/abs/1302.6576

    Orderability, contact non-squeezing, and Rabinowitz Floer homology

Or

    [ physics:gr-qc ]
    http://arxiv.org/abs/gr-qc/0208028

    Possible time variations of G in scalar-tensor theories of gravity

Or

    [ physics:hep-lat ]
    http://arxiv.org/abs/hep-lat/9503018

    Cooling and the SU(2) Instanton Vaccuum

Or 

    [ cs ]
    http://arxiv.org/abs/1011.2836

    System Virtualization and Efficient ID Transmission Method for RFID Tag Infrastructure Network


Enjoy!
