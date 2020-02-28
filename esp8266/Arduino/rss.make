#!/bin/sh

dir=$(cd ${0%/*}; pwd)

date=$(date -u)

cd ${dir}

v="$1"
[ -r "${v}" ] && pr=$(cat ${v})

(
cat << EOF
<item>
    <title>esp8266/Arduino core snapshot: ${v} (PR: ${pr}) $date</title>
    <description>snapshot esp8266/Arduino board installer</description>
    <pubDate>$(date)</pubDate>
    <link>https://d-a-v.github.io</link>
</item>
EOF
cat rss.items.xml
) > rss.items.xml.new
mv rss.items.xml.new rss.items.xml

(
cat rss.xml.template | sed -e "s,DATE,$(date -u),g"
cat rss.items.xml
cat << EOF
  </channel>
</rss>
EOF
) > ../../rss.xml
