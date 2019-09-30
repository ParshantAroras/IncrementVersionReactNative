#!/usr/bin/env bash -e

PROJECT_DIR="ios/IncrementVersion"
INFOPLIST_FILE="Info.plist"
INFOPLIST_DIR="${PROJECT_DIR}/${INFOPLIST_FILE}"

PACKAGE_VERSION=$(cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[[:space:]]')
echo $PACKAGE_VERSION
BUILD_NUMBER=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${INFOPLIST_DIR}")
BUILD_NUMBER=$(($BUILD_NUMBER + 1))

echo ${BUILD_NUMBER}
# Update plist with new values
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${PACKAGE_VERSION#*v}" "${INFOPLIST_DIR}"

/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $BUILD_NUMBER" "${INFOPLIST_DIR}"

# git add "${INFOPLIST_DIR}"

# /usr/libexec/PlistBuddy -c "Set :CFBundleVersion 1.0.1" "ios/IncrementVersion/Info.plist"
# /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString 1.0.1" "ios/IncrementVersion/Info.plist"