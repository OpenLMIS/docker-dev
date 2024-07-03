#!/bin/sh

# This script initializes the Transifex client. It then uploads the source resource to the 
# Transifex project and downloads the translated resources into the build.

# Some things to note:
# - The .tx folder, if it exists, is deleted beforehand so that the 'tx init' does not need to 
#   prompt to overwrite it.
# - The .tx folder is generated each time, rather than saving the .tx/config file into version 
#   control, because a .transifexrc also needs to be generated using the username and password.
#   Since these credentials should not be in version control, the regeneration approach is used.

rm -rf .tx

# Set default behavior based on environment variables (pull by default, push only on purpose)
TX_PUSH=${TRANSIFEX_PUSH:-false}
TX_PULL=${TRANSIFEX_PULL:-true}

while [[ $# -gt 1 ]]; do
  case "$1" in
    --push)
      TX_PUSH=true ;;
    --pull)
      TX_PULL=true ;;
    --source-file)
      SOURCE_FILE="$2"
      shift
      ;;
    --resource)
      RESOURCE="$2"
      shift
      ;;
    --pattern)
      PATTERN="$2"
      shift
      ;;
    *)
      ;;
  esac
  shift
done

tx init

tx add --file-filter=$PATTERN \
  --type=UNICODEPROPERTIES \
  --organization=openlmis \
  --project=$RESOURCE \
  --resource="messages ${SOURCE_FILE}"

if [ "$TX_PUSH" == "true" ]; then
  tx push -s
fi

if [ "$TX_PULL" == "true" ]; then
  tx pull -a -f
fi
