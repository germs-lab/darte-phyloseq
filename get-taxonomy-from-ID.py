import os
import json
import urllib
import sys
import subprocess
from Bio import SeqIO
import pycurl
import cStringIO

if len(sys.argv) != 2:
    print "USAGE: get-taxonomy-from-ID.py <ID file>"
    sys.exit(1)

l_id = []

for id in open(sys.argv[1]):
    dat = id.rstrip().split('\t')[-1]
    l_id.append(dat)

for item in l_id:
    id = str(item)
    buf = cStringIO.StringIO()
    c = pycurl.Curl()
    c.setopt(c.URL, 'http://eutils.ncbi.nlm.nih.gov/entrez/\
eutils/efetch.fcgi?db=nuccore&id=' + id + '&rettype=gb&retmode=text')
    c.setopt(c.WRITEFUNCTION, buf.write)
    c.perform()

    x= buf.getvalue()

    dat = x.split('\n')
    for n, each in enumerate(dat):
        each = each.strip()
        if each.startswith("ORGANISM"):
            print "\t".join([id, each, dat[n+1].strip()])
