#!/usr/bin/env bash

echo -ne '\n' | git credential-osxkeychain erase && host=github.com && protocol=https
echo "credential cleaned"
