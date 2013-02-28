from glob import glob
from BeautifulSoup import BeautifulStoneSoup as bs

COLOR_OFF = "\033[0m"
COLOR_PURPLE = "\033[0;35m"
COLOR_CYAN = "\033[0;36m"
COLOR_BLUE = "\033[1;34m"
COLOR_BOLD_PURPLE='\033[1;35m'


def makeFortunes(outname = "arxiv_fortunes.txt"):
    outf = open(outname, 'w')
    records = parseAllFiles()
    
    for setSpecs, paperUrl, title in records:
        formatted = format(setSpecs, paperUrl, title)
        outf.write(formatted)
        outf.write("\n%\n")
        
    outf.write("You are a beautiful animal.")
    outf.close()
    
    
    
def format(setSpecs, paperUrl, title):
    """
    I want the to be purple, url to be blue, and the title to be bold
    """
    
    specs = COLOR_PURPLE
    setSpecs.sort()
    for spec in setSpecs:
        specs += "[ " + spec + " ]"
        
    specs += COLOR_OFF
        
    paperUrl = COLOR_BLUE + paperUrl + COLOR_OFF
    
    title = COLOR_BOLD_PURPLE + title.replace("\n", '').replace("  ", " ") + COLOR_OFF


    return specs + "\n" + paperUrl + "\n\n" + title



def parseAllFiles():
    fnames = glob("*.xml")
    

    for fname in fnames:
        try:
            recs = parseFile(fname)
            for rec in recs:
                yield rec
        except:
            print "WARNING: Error parsing file %s" % fname
    

        
        
def parseFile(fname):
    """
    Returns a list of parsed record tuples
    """
    data = open(fname).read()
    databs = bs(data)
    
    records = databs.findAll("record")
    
    return [parseRecord(record) for record in records]
    
    
def parseRecord(record):
    """
    Returns a tuple of [header.secSpec], metadata.arXiv.id, metadata.arXiv.title
    """
    # for some reason, beautifulsoup makes all tags lowercase for you
    setSpecs = [x.text for x in record.findAll("setspec")]
    paperUrl = "http://arxiv.org/abs/" + record.find("id").text
    title = record.find("title").text
    
    return (setSpecs, paperUrl, title)
    
    
    
if __name__ == "__main__":
    makeFortunes()

        
    
