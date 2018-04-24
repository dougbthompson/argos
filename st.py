#!/usr/bin/python

import xml.etree.ElementTree
e = xml.etree.ElementTree.parse('zxml.xml').getroot()

# standard
print e.tag, e.attrib

for child in e:
    e1 = child
    for child in e1:
        e2 = child
        for child in e2:
            e3 = child
            if e3.tag == "SubFactor":
                for child in e3:
                    e4 = child
                    print e1.tag, e1.attrib
                    print e2.tag, e2.attrib
                    print e3.tag, e3.attrib
                    print e4.tag, e4.attrib
            else:
                e4 = e3
                print e1.tag, e1.attrib
                print e2.tag, e2.attrib
                print e4.tag, e4.attrib

# e : Standard
# e1: Criteria
# e2: Factor
# e3: SubFactor
# e4: ScoreOption

