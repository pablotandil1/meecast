#!/bin/bash

ALL_LANGUAGES="ru_RU fi_FI fr_FR en_GB en_US it_IT de_DE es_ES es_MX pl_PL bg_BG lv_LV sk_SK"

xgettext --from-code=UTF-8 --keyword=_ --keyword=Q_ -f po/POTFILES.in -s -C -o po/omweather.pot
cd po
for language in $ALL_LANGUAGES; do
    echo -n "$language: "
    msgmerge -U $language.po omweather.pot
done
cd ..

intltool-extract --type=gettext/xml data/help/omweather.xml.in
xgettext --from-code=utf-8 --keyword=N_ -f data/help/po/POTFILES.in -s -C -o data/help/po/omweather_help.pot
cd data/help/po
for language in $ALL_LANGUAGES; do
    echo -n "$language: "
    msgmerge -U $language.po omweather_help.pot
done
cd ../..

exit 0
