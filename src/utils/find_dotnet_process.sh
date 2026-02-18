#!/bin/bash

# Script to find running dotnet process PID for a given source file
# Finds the child process to attach a debugger to
# Usage: ./find-dotnet-process.sh <file-path>
# Output: PID number only

if [ -z "$1" ]; then
    echo "Usage: $0 <file-path>" >&2
    exit 1
fi

FILE_PATH=$(realpath "$1")

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File '$FILE_PATH' not found" >&2
    exit 1
fi

FILE_DIR=$(dirname "$FILE_PATH")

# Find the nearest .csproj file
CSPROJ=""
SEARCH_DIR="$FILE_DIR"

while [ "$SEARCH_DIR" != "/" ]; do
    FOUND=$(find "$SEARCH_DIR" -maxdepth 1 -name "*.csproj" | head -n 1)
    if [ -n "$FOUND" ]; then
        CSPROJ="$FOUND"
        break
    fi
    SEARCH_DIR=$(dirname "$SEARCH_DIR")
done

if [ -z "$CSPROJ" ]; then
    echo "Error: No .csproj file found for '$FILE_PATH'" >&2
    exit 1
fi

PROJECT_NAME=$(basename "$CSPROJ" .csproj)

# For each dotnet process, check its child (the actual app process).
# The child's bin directory will contain our DLL if the app depends on it.
for PID in $(pgrep -x dotnet 2>/dev/null); do
    CHILD=$(pgrep -P $PID 2>/dev/null | head -n 1)
    [ -z "$CHILD" ] && continue

    # Get the child's executable path
    CHILD_EXE=$(readlink -f /proc/$CHILD/exe 2>/dev/null)
    [ -z "$CHILD_EXE" ] && continue

    # Check if our project's DLL exists in the same directory as the child exe
    CHILD_DIR=$(dirname "$CHILD_EXE")
    if [ -f "$CHILD_DIR/$PROJECT_NAME.dll" ]; then
        echo "$CHILD"
        exit 0
    fi
done

echo "Error: No running process found with $PROJECT_NAME.dll loaded" >&2
exit 1
