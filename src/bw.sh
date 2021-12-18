#!/bin/bash
#remove Gemfile.lock
rm Gemfile.lock

#install bundle
gem install bundle

#install the gems
bundle install
gem install postmark

#check for gem
# if ! gem spec "tty-color" > /dev/null 2>&1; then
#   echo "Gem tty-color is not installed!"
# fi

# check ruby version
currentversion="$(ruby -v)"
currentver=$(echo $currentversion | cut -dp -f1 | sed 's/\.//g')
requiredver="300"
 if  [ "$currentver" -ne "$requiredver" ] 
 then 
        echo "You have a $currentversion version  --- required is 3.0.0"
        echo "It might affect some functionality"
        read -p "Press enter to continue"
        ruby main.rb   
else     
       read -p "Successfully installed Press enter to continue"
        ruby main.rb   
 fi

#clear the screen
clear


