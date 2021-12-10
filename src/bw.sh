#!/bin/bash
currentversion="$(ruby -v)"
currentver=$(echo $currentver | cut -dp -f1 | sed 's/\.//g')
requiredver="600"
 if  [ "$currentver" != "$requiredver" ] 
 then 
        echo "You have a different version  than the required"
        echo "It might affect some functionality"
        read -p "Press enter to continue"
        ruby main.rb        
 
 fi


#ruby main.rb 