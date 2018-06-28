#!/bin/sh

if [ -z "$NEO_HOST" ]; then
    echo "NEO_HOST environment variable should be set"
    exit 1
fi

if [ -z "$NEO_PORT" ]; then
    echo "NEO_PORT environment variable should be set"
    exit 1
fi

echo $NEO_PASSWORD > pass.txt

if [ -z "$NEO_MIG_CONTEXT" ]; then
    echo "Run neo migration with default context: common"
    NEO_MIG_CONTEXT=common
else
    echo "Run neo migration with contexts: $NEO_MIG_CONTEXT"
fi

if [ -z "$NEO_USERNAME" ]; then 
    ./liquigraph.sh --changelog /usr/scripts/changelog.xml \
        --graph-db-uri jdbc:neo4j:$NEO_HOST:$NEO_PORT/ \
        --execution-contexts $NEO_MIG_CONTEXT \
        --dry-run-output-directory /tmp
else 
   ./liquigraph.sh --changelog /usr/scripts/changelog.xml \
        --graph-db-uri jdbc:neo4j:$NEO_HOST:$NEO_PORT/ \
        --execution-contexts $NEO_MIG_CONTEXT \
        --dry-run-output-directory /tmp \
        --username $NEO_USERNAME --password < pass.txt
fi

echo "\n Running follow migrations:"
cat /tmp/output.cypher

if [ -z "$NEO_USERNAME" ]; then 
    ./liquigraph.sh --changelog /usr/scripts/changelog.xml \
        --graph-db-uri jdbc:neo4j:$NEO_HOST:$NEO_PORT/ \
        --execution-contexts $NEO_MIG_CONTEXT
else 
   ./liquigraph.sh --changelog /usr/scripts/changelog.xml \
        --graph-db-uri jdbc:neo4j:$NEO_HOST:$NEO_PORT/ \
        --execution-contexts $NEO_MIG_CONTEXT \
        --username $NEO_USERNAME --password < pass.txt
fi
