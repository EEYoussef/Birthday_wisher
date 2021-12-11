#!/bin/bash


#remove Gemfile.lock
rm Gemfile.lock

#install bundle
gem install bundle

#install the gems
bundle install

#check for gem
# if ! gem spec "tty-color" > /dev/null 2>&1; then
#   echo "Gem tty-color is not installed!"
# fi

# check ruby version
currentversion="$(ruby -v)"
currentver=$(echo $currentver | cut -dp -f1 | sed 's/\.//g')
requiredver="300"
 if  [ "$currentver" != "$requiredver" ] 
 then 
        echo "You have a different version  than the required"
        echo "It might affect some functionality"
        read -p "Press enter to continue"
        ruby main.rb        
 
 fi

#clear the screen
clear


