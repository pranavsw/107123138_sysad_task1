#!/bin/bash
echo "Enter task number to display status for (1-3):"
read task_number
echo "Enter domain to filter by (optional):"
read domain

submitted_count=0
total_mentees=$(ls /home/core/mentees | wc -l)

for mentee in /home/core/mentees/*; do
    if [ -f "$mentee/task_submitted.txt" ] && grep -q "Task $task_number submitted" "$mentee/task_submitted.txt"; then
        submitted_count=$((submitted_count + 1))
    fi
done

percentage=$(echo "scale=2; $submitted_count / $total_mentees * 100" | bc)
echo "Task $task_number submission percentage: $percentage%"

# Display mentees who submitted the task
echo "Mentees who submitted Task $task_number:"
for mentee in /home/core/mentees/*; do
    if [ -f "$mentee/task_submitted.txt" ] && grep -q "Task $task_number submitted" "$mentee/task_submitted.txt"; then
        if [ -z "$domain" ] || [ -d "$mentee/$domain" ]; then
            echo "$(basename "$mentee")"
        fi
    fi
done