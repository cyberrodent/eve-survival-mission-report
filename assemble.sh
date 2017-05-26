#!/bin/bash

# 
# This script takes a directory where you have wgetted eve-survival
# From that directory it will create a new directory with all the links
# replaced to local ones and comments embedded in the page.
#
# You end up with less clicking and faster loading mission reports
# You give up getting any recent comments.
#

SOURCE="originals"
DEST="reports"

# start clean
rm -rf ${DEST}

# where we put things
mkdir -p ${DEST}

cp ./${SOURCE}/*show_comments* ${DEST}
cp ./${SOURCE}/wikka.php\?wakka=MissionReports ${DEST}/

# -----------
cd ${DEST}
# -----------

# rename the show_comments links as the main one
rename 's/&show_comments=1//' wikka*
# drop the wikka part
rename "s/wikka.php\?wakka=//" wikka.php\?wakka=*
# add the .html to the end
rename "s/$/.html/" *

cp -r ../${SOURCE}/templates .
cp -r ../${SOURCE}/images .
cp -r ../${SOURCE}/screenshots .

# some special treatment for these query string escaped files
mv ./templates/default/css/wikka.css\?a8278 ./templates/default/css/wikka.css

# strip the eve-survival link
find ./ -type f -exec sed -i.bak 's/http:\/\/eve-survival.org/./g' {} \;

# Update the links in the documents
find ./ -name "*.html" -type f -exec sed -r -i.bak 's/wikka.php\?wakka=(\w+)/\1.html/g' {} \;

# clean up bak
find ./ -name "*.bak" -type f -exec rm {} \;

ln -s MissionReports.html index.html
# back whence you came
cd -


