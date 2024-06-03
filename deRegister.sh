#!/bin/bash
echo "Enter your roll number:"
read roll_number
echo "Enter the domains you want to deregister from (space-separated):"
read -a domains

for domain in "${domains[@]}"; do
    rm -rf /home/core/mentees/"$roll_number"/"$domain"
    sed -i "/$domain/d" /home/core/mentees/"$roll_number"/domain_pref.txt
done

if [ ! "$(ls -A /home/core/mentees/"$roll_number")" ]; then
    sudo userdel -r "$roll_number"
    sed -i "/$roll_number/d" /home/core/mentees_domain.txt
fi

for mentor_file in /home/core/mentors/*/*/allocatedMentees.txt; do
    sed -i "/$roll_number/d" "$mentor_file"
done