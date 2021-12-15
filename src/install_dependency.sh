#!/bin/bash
gem install bundler
bundle install
if ! gem spec "tty-color" > /dev/null 2>&1; then
  echo "Gem tty-color is not installed!"
fi