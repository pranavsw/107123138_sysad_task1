#!/bin/bash
echo "Enter your roll number:"
read roll_number
echo "Enter the task number (1-3):"
read task_number

echo "Task $task_number submitted" >> /home/core/mentees/"$roll_number"/task_submitted.txt

for domain in $(ls /home/core/mentees/"$roll_number"); do
    if [ -d /home/core/mentees/"$roll_number"/"$domain" ]; then
        mkdir -p /home/core/mentees/"$roll_number"/"$domain"/task"$task_number"
    fi
done

if id -nG "$USER" | grep -qw "mentors"; then
    domain=$(echo "$USER" | cut -d'/' -f1)
    for mentee_dir in /home/core/mentees/*; do
        roll_number=$(basename "$mentee_dir")
        if [ -d "$mentee_dir/$domain/task$task_number" ]; then
            ln -s "$mentee_dir/$domain/task$task_number" /home/core/mentors/"$domain"/"$USER"/submittedTasks/task"$task_number"/"$roll_number"
            if [ "$(ls -A "$mentee_dir/$domain/task$task_number")" ]; then
                echo "Task $task_number completed" >> "$mentee_dir/task_completed.txt"
            fi
        fi
    done
fi