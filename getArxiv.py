import urllib2
import time
from BeautifulSoup import BeautifulStoneSoup as bs
import logging

BASE_URL = "http://export.arxiv.org/oai2?verb=ListRecords&metadataPrefix=arXiv"
RESUME_URL = "http://export.arxiv.org/oai2?verb=ListRecords&resumptionToken="

SLEEP_TIME = 20
findex = 1


def sleep():
    logging.debug("Sleeping")
    time.sleep(SLEEP_TIME)
    
    
    

def getRecords(url):    
    data = readUrl(url)
    storeData(data)
    resumptionToken = getResumptionToken(data)
    sleep()
    
    while resumptionToken is not None:
        url = RESUME_URL + resumptionToken
        data = readUrl(url)
        storeData(data)
        resumptionToken = getResumptionToken(data)
        sleep()

    


def readUrl(url):
    logging.info("Retrieving %s" % url)

    response = urllib2.urlopen(url)
    data = response.read()
    
    return data




def storeData(data):
    fname = "arXiv-records-%.3d.xml"    
    
    global findex
    logging.info("Writing out file %s" % (fname % findex))
    
    outf = open(fname % findex, 'w')
    
    findex += 1
    outf.write(data)
    outf.close()
    




def getResumptionToken(data):
    retToken = None
    databs = bs(data)
    resList = databs.findAll("resumptiontoken")
    if resList != []:
        retToken = resList[0].text
        
    logging.debug("Found resumption token %s" % str(retToken))
    return retToken
        
        
        
        
if __name__ == "__main__":
    logging.basicConfig(filename = '_arXiv.log', level=logging.DEBUG, format='%(asctime)s %(levelname)s %(message)s', datefmt='%m/%d/%Y %I:%M:%S %p')
    getRecords(BASE_URL)
    logging.info("Done!")
