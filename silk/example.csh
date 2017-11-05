#!/bin/csh

foreach i (*.silk)
	decoder $i $i.pcm
	ffmpeg -f s16le -ar 22050 -ac 1 -acodec pcm_s16le -i $i.pcm $i.wav
end

