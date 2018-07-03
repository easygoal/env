#!/usr/bin/env python3

infile = open('efuse.vhx32','r',-1)
otfile = open('efuse.bit_reverse.vhx32','w',-1)

for line in infile:
    value = line[:-1]      # remove '\n'
    value = int(value,16)
    b     = '{0:#0{1}x}'.format( int('{:032b}'.format(value)[::-1],2),10 )+'\n'
    otfile.write(b[2:])    # remove leading '0x'

infile.close()
otfile.close()

