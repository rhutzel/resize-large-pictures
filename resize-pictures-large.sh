#!/bin/bash

# Saves a resized copy of each JPEG in the working directory to a "large" subdirectory.
# Files that exceed 1MB are resized to three quarters.
# Files that exceed 2MB are resized in half.
# The convert command comes from the imagemagick binaries.

mkdir --parents large;

for f in *.jpg; do
  renamed=`echo "$f" | sed 's/^\(.*\)\.jpg$/large\/\1-lg.jpg/'`;
  if [ $(wc -c < "$f") -ge 2048000 ]; then
    echo "50% | $f";
    convert $f -resize 30% $renamed;
  elif [ $(wc -c < "$f") -ge 1024000 ]; then
    echo "75% | $f";
    convert $f -resize 50% -strip $renamed;
  else
    echo "... | $f";
    cp $f $renamed;
  fi
done

echo -e "\nConverted files saved to ./large/\n"

