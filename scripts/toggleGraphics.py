#!/usr/bin/env python3

import re
import sys

xorgConf = '/home/daniel/dotFiles/xorg.conf.default'
xorgConfWrite = '/etc/X11/xorg.conf'
dedicatedSymbolEx = 'UseDedicatedEx'
dedicatedSymbolIn = 'UseDedicatedIn'
onboardSymbol = 'UseOnboard'

def commentIn(writeLines, line):
    writeLines.append(line)
    writeLines.append(lines.pop(index+1).rstrip().replace("#", ""))

def commentOut(writeLines, line):
    writeLines.append(line)
    writeLines.append("#"+lines.pop(index+1).rstrip())
    return line

f = open(xorgConf)
lines = f.readlines()
writeLines = []
f.close()

if len(sys.argv) < 2:
    print("Too few arguments")
    exit(1)

if str(sys.argv[1]) == 'dedicatedEx':
    useDedicatedEx = True
    useDedicatedIn = False
elif str(sys.argv[1]) == 'dedicatedIn':
    useDedicatedEx = False
    useDedicatedIn = True
elif str(sys.argv[1]) == 'onboard':
    useDedicatedEx = False
    useDedicatedIn = False
else:
    print("Option does not match, try 'dedicatedEx', 'dedicatedIn' or 'onboard'")
    exit(1)

# We comment lines in also if there are already commentend in
for index,line in enumerate(lines):
    line = line.rstrip()
    if re.search('.*'+dedicatedSymbolEx+'.*', line):
        if index+1 >= len(lines):
            print("Fehler: danch kommt nix mehr in der Datei!")
            exit(1)
        else:
            if useDedicatedEx or useDedicatedIn:
                commentIn(writeLines, line)
            else:
                commentOut(writeLines, line)
    elif re.search('.*'+onboardSymbol+'.*', line):
        if index+1 >= len(lines):
            print("Fehler: danch kommt nix mehr in der Datei!")
            exit(1)
        else:
            if (not useDedicatedEx) and (not useDedicatedIn):
                commentIn(writeLines, line)
            else:
                commentOut(writeLines, line)
    elif re.search('.*'+dedicatedSymbolIn+'.*', line):
        if index+1 >= len(lines):
            print("Fehler: danch kommt nix mehr in der Datei!")
            exit(1)
        else:
            if useDedicatedIn:
                commentIn(writeLines, line)
            else:
                commentOut(writeLines, line)
    else:
        writeLines.append(line)


f = open(xorgConfWrite, 'w')
for line in writeLines:
    f.write(line+'\n')
    #print("Schreiben: "+line)
f.close()
