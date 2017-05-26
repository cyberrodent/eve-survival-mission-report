#!/bin/bash

#
# Fetch down eve-survival.
# In order to optimize for bandwidth, we feed a filelist to wget.
# This list is of just the pages we want with show_comments.
# assemble.sh will sed the links to be local and rename the files

# cd into this directory before getting files, they end up in here
DLOADDIR="_download"

WGET=/usr/bin/wget

URL="http://eve-survival.org/wikka.php?wakka=MissionReports"
# URL="http://eve-survival.org/wikka.php?wakka=PageIndex"

OPTS=( )
# makes an array of options


# the filelist file was created like so after wgetting everything
# find ./ | grep wakka | grep -v comment | grep -v edit > .filelist_01

OPTS[${#OPTS[@]}]="-w 2"    # Wait between Requests
OPTS[${#OPTS[@]}]="--no-host-directories" 
OPTS[${#OPTS[@]}]="-nc"     # No Clobber
OPTS[${#OPTS[@]}]="-i .filelist_02"


rm -rf ${DLOADDIR}
mkdir -p ${DLOADDIR}
cd ${DLOADDIR}

echo ${WGET} ${OPTS[@]} ${URL}
${WGET} ${OPTS[@]} ${URL}

cd -
