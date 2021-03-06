#!/bin/sh

# Test which node.js command to use
# (debian seems to use nodejs instead of just node)
if test -f "/usr/bin/nodejs"
then
    NODEJS="nodejs"
else
    NODEJS="node"
fi

# Find the real name of this file, following symlinks
REALPATH=$0
while test -L $REALPATH
do
    REALPATH=`readlink $REALPATH`
done

# Location of the main kanso.js node script
SCRIPT_PATH=`dirname $REALPATH`/run_tests.js

# Additional path for looking up node modules.
# Used so kanso package pre/postprocessors can do require('kanso/lib/foo')
KANSO_DIR=`dirname $REALPATH`/..

# Extend existing NODE_PATH environment variable
export NODE_PATH="$KANSO_DIR/src:$KANSO_DIR/deps:$NODE_PATH"

# Run scripts/kanso.js
exec $NODEJS $SCRIPT_PATH $@
