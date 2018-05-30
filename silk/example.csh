#!/bin/csh

foreach i (*.silk)
	decoder $i $i.pcm
	ffmpeg -f s16le -ar 22050 -ac 1 -acodec pcm_s16le -i $i.pcm $i.wav
	ffmpeg -i $i.wav -acodec libfdk_aac -vbr 1 -i $i.wav $i.m4a
end

