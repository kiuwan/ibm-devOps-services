#!/bin/bash
KIUWAN_TMP_DIR="`mktemp -d`"
KIUWAN_ANALYZER_PATH="$KIUWAN_TMP_DIR/KiuwanLocalAnalyzer.zip"
wget https://www.kiuwan.com/pub/analyzer/KiuwanLocalAnalyzer.zip -O "$KIUWAN_ANALYZER_PATH"
unzip -o "$KIUWAN_ANALYZER_PATH" -d "$KIUWAN_TMP_DIR"
chmod 700 "$KIUWAN_TMP_DIR/KiuwanLocalAnalyzer/bin/agent.sh"
"$KIUWAN_TMP_DIR/KiuwanLocalAnalyzer/bin/agent.sh" -s "`pwd`/$KIUWAN_SOURCE_CODE_DIRECTORY" -n "$KIUWAN_APPLICATION_NAME" -l "$KIUWAN_ANALYSIS_LABEL" -c --user "$KIUWAN_USER" --pass "$KIUWAN_PASSWORD" supported.technologies="$KIUWAN_TECHNOLOGIES_TO_ANALYZE" include.patterns="$KIUWAN_INCLUDE_PATTERNS" exclude.patterns="$KIUWAN_EXCLUDE_PATTERNS,`pwd`/$ARCHIVE_DIR/**"
