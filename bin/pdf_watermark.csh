#!/bin/csh 

if !(-d watermark) then
  mkdir watermark
endif

foreach i (*.pdf)
  pdftk $i multistamp /mnt/e/tmp/siengine_confidential.pdf output watermark/$i
end

### /bin/bash
#for i in *.pdf; do
#  python /mnt/e/work/github/pdfrw/examples/watermark.py $i /mnt/e/tmp/siengine_confidential.pdf
#done

