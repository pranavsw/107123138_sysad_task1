#!/bin/bash

echo "Enter your roll number:"
read roll_number
echo "Enter your name"
read name
echo "Enter your domain preferences (e.g., web->app->sysad):"
read preferences

echo "$roll_number $name $preferences" >> /home/core/mentees_domain.txt

IFS='->' read -r -a selected_domains <<< "$preferences"
for domain in "${selected_domains[@]}"; do
    sudo mkdir /home/core/mentees/$roll_number/$domain
    echo "$domain " >> /home/core/mentees/$roll_number/domain_pref.txt
done