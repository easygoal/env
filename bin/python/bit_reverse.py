#!/usr/bin/env python3

f=open('bit_reverse.vhx32','w')

f.write( '{0:#0{1}x}'.format( int('{:032b}'.format(0xfffffff2)[::-1],2),10 )+'\n' )
f.write( '{0:#0{1}x}'.format( int('{:032b}'.format(0x0000000a)[::-1],2),10 )+'\n' )
f.write( '{0:#0{1}x}'.format( int('{:032b}'.format(0x9030f50c)[::-1],2),10 )+'\n' )
f.write( '{0:#0{1}x}'.format( int('{:032b}'.format(0x00010005)[::-1],2),10 )+'\n' )

f.close()

