#!/bin/zsh

echo -ne '\n' | git credential-osxkeychain erase && host=github.com && protocol=https
echo "Credential cleaned"
