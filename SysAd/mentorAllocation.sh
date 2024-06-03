#!/bin/bash
declare -A mentor_capacity

while IFS= read -r mentor; do
    name=$(echo "$mentor" | cut -d' ' -f1)
    domain=$(echo "$mentor" | cut -d' ' -f2)
    capacity=$(echo "$mentor" | cut -d' ' -f3)
    mentor_capacity["$domain/$name"]=$capacity
done < <(sed '1d' mentorDetails.txt)

while IFS= read -r line; do
    roll_number=$(echo "$line" | cut -d' ' -f1)
    preferences=($(echo "$line" | cut -d' ' -f3- | tr '->' '\n'))

    allocated=false
    for domain in "${preferences[@]}"; do
        for mentor in "${!mentor_capacity[@]}"; do
            if [[ $mentor == $domain/* ]]; then
                if [ ${mentor_capacity[$mentor]} -gt 0 ]; then
                    echo "$roll_number" >> /home/core/mentors/"$mentor"/allocatedMentees.txt
                    mentor_capacity[$mentor]=$((mentor_capacity[$mentor]-1))
                    allocated=true
                    break
                fi
            fi
        done
        [ "$allocated" = true ] && break
    done
done < /home/core/mentees_domain.txt