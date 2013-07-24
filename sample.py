#!/usr/bin/env python

from random import sample

fortunes = open("arxiv_fortunes.txt").read()
L = fortunes.split("\n%\n")
smaller = sample(L, 1000)
smaller_str = "\n%\n".join(smaller)

out = open("smaller-" + str(hash(smaller_str)) + ".txt", 'w')
out.write(smaller_str)
out.close()
