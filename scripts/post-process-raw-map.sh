#/bin/sh
# This script will create a suitable map.png file from a raw minimap dump.
# It requires ImageMagick to work.
#
# Made by magicus (https://github.com/magicus)
#

MYDIR=$(cd $(dirname "$0") > /dev/null && pwd)

#### Process main map

# mask is 4034x6414
RAW_FILE_NAME="$MYDIR/../worldmap/rawmap/map-raw-main.png"
# Offset of mask into the raw map file
RAW_FILE_OFFSET_X=177
RAW_FILE_OFFSET_Y=83

MASK_FILE_NAME="$MYDIR/../reference/map-mask.png"
MASK_FILE_SIZE=4034x6414

MAP_NAME="main"
OUTPUT_FILE_NAME="$MYDIR/../$MAP_NAME-map.png"

# First crop the input map to match the mask dimensions, using offset 167+48
# Then make all black areas on the mask 100% alpha
# Then do "vibrance", turning up the saturation of unsaturated colors
# (Inspired by http://www.fmwconcepts.com/imagemagick/vibrance3/index.php)
# Finally store as max commpressed png, using -quality 94 == max zlib compression
# with the Paeth filter.

magick $RAW_FILE_NAME -crop $MASK_FILE_SIZE+$RAW_FILE_OFFSET_X+$RAW_FILE_OFFSET_Y +repage $MASK_FILE_NAME -alpha off -compose CopyOpacity -composite -colorspace HCL -channel g -sigmoidal-contrast 2,0% +channel -colorspace sRGB +repage -quality 94 $OUTPUT_FILE_NAME
MD5=$(md5sum $OUTPUT_FILE_NAME | cut -d' ' -f1)
echo '{"file":"'$MAP_NAME'-map.png","x1":-2383,"z1":-6573,"x2":1651,"z2":-159,"hash":"'$MD5'"}'

#### Process side maps

# Bonfire

# mask and map is 1024 x 512
RAW_FILE_NAME="$MYDIR/../worldmap/rawmap/map-raw-bonfire.png"
# Offset of mask into the raw map file
RAW_FILE_OFFSET_X=0
RAW_FILE_OFFSET_Y=0

MASK_FILE_NAME="$MYDIR/../reference/map-mask-bonfire.png"
MASK_FILE_SIZE=1024x512

MAP_NAME="bonfire"
OUTPUT_FILE_NAME="$MYDIR/../$MAP_NAME-map.png"

# First crop the input map to match the mask dimensions, using offset 167+48
# Then make all black areas on the mask 100% alpha
# Then do "vibrance", turning up the saturation of unsaturated colors
# (Inspired by http://www.fmwconcepts.com/imagemagick/vibrance3/index.php)
# Finally store as max commpressed png, using -quality 94 == max zlib compression
# with the Paeth filter.

magick $RAW_FILE_NAME -crop $MASK_FILE_SIZE+$RAW_FILE_OFFSET_X+$RAW_FILE_OFFSET_Y +repage $MASK_FILE_NAME -alpha off -compose CopyOpacity -composite -colorspace HCL -channel g -sigmoidal-contrast 2,0% +channel -colorspace sRGB +repage -quality 94 $OUTPUT_FILE_NAME
MD5=$(md5sum $OUTPUT_FILE_NAME | cut -d' ' -f1)
echo '{"file":"'$MAP_NAME'-map.png","x1":-2048,"z1":9728,"x2":-1025,"z2":10239,"hash":"'$MD5'"}'
