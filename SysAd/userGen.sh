#!/bin/bash

sudo useradd -m core
sudo mkdir /home/core/mentors /home/core/mentees

MENTEES=$(cat ./details_files/menteeDetails.txt | sed '1d') 
MENTORS=$(cat ./details_files//mentorDetails.txt | sed '1d')

for mentee in $MENTEES; do
  IFS=' ' read -r mentee_name roll_number <<< "$mentee"
  sudo useradd -m -d /home/core/mentees/$roll_number $roll_number
  sudo touch /home/core/mentees/$roll_number/domain_pref.txt
  sudo touch /home/core/mentees/$roll_number/task_completed.txt
  sudo touch /home/core/mentees/$roll_number/task_submitted.txt
  sudo chmod 700 /home/core/mentees/$roll_number
done

sudo mkdir /home/core/mentors/web /home/core/mentors/app /home/core/mentors/sysad

for mentor in $MENTORS; do
  IFS=' ' read -r mentor_name domain capacity <<< "$mentor"
  sudo useradd -m -d /home/core/mentors/$domain/$mentor_name $mentor_name
  sudo touch /home/core/mentors/$domain/$mentor_name/allocatedMentees.txt
  sudo mkdir /home/core/mentors/$domain/$mentor_name/submittedTasks
  sudo mkdir /home/core/mentors/$domain/$mentor_name/submittedTasks/task1
  sudo mkdir /home/core/mentors/$domain/$mentor_name/submittedTasks/task2
  sudo mkdir /home/core/mentors/$domain/$mentor_name/submittedTasks/task3
  sudo chmod 700 /home/core/mentors/$domain/$mentor_name
done


sudo chmod 755 /home/core
sudo touch /home/core/mentees_domain.txt
#mentee(other) should have only write access
sudo chmod 662 /home/core/mentees_domain.txt