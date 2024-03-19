#!/usr/bin/env bash
#
# This script assumes a linux environment

DES=$1/assets

printf "*** Packaging assets in $DES... "

if [ -n "${TRAVIS_TAG}" ]; then
  pushd .. > /dev/null
  git clone --depth 1 https://github.com/uBlockOrigin/uAssets.git
  popd > /dev/null
fi

rm -rf $DES
mkdir $DES
cp    ./assets/assets.json                                       $DES/

mkdir $DES/thirdparties
wget https://easylist.to/easylist/easylist.txt                                         -P $DES/thirdparties/easylist/
wget https://easylist.to/easylist/easyprivacy.txt                                      -P $DES/thirdparties/easylist/
# EasyList (Optimized)
wget https://filters.adtidy.org/extension/ublock/filters/101_optimized.txt             -P $DES/thirdparties/easylist/
# EasyPrivacy (Optimized)
wget https://filters.adtidy.org/extension/ublock/filters/118_optimized.txt             -P $DES/thirdparties/easylist/
cp -R ../uAssets/thirdparties/pgl.yoyo.org                                                $DES/thirdparties/
cp -R ../uAssets/thirdparties/publicsuffix.org                                            $DES/thirdparties/
cp -R ../uAssets/thirdparties/urlhaus-filter                                              $DES/thirdparties/

mkdir $DES/ublock
find ../uAssets/filters/ -type f -name "*.txt" \
                               ! -name "annoyances*.txt" \
                               ! -name "badlists.txt" \
                               ! -name "lan-block.txt" \
                               ! -name "legacy.txt" \
                               ! -name "ubol-filters.txt" \
                                                     -exec cp {} $DES/ublock \;
cp    ./assets/resources/resources.txt                           $DES/ublock/
cp    ./assets/resources/legacy.txt                              $DES/ublock/

echo "done."
