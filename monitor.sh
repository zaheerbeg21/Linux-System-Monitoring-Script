#!/bin/bash

CPU_THRESHOLD=15
RAM_THRESHOLD=80
DISK_THRESHOLD=80

LOG_FILE="logs/system_usage.log"
ALERT_FILE="alerts/alert.log"

mkdir -p logs alerts

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_USAGE=$(printf "%.0f" "$CPU_USAGE")

# RAM Usage
RAM_USAGE=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}')

# Disk Usage
DISK_USAGE=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')

# Create header if log file doesn't exist
if [ ! -f "$LOG_FILE" ]; then
    printf "%-20s %-10s %-10s %-10s\n" \
    "Timestamp" "CPU(%)" "RAM(%)" "Disk(%)" > "$LOG_FILE"
fi

# Save metrics
printf "%-20s %-10s %-10s %-10s\n" \
"$TIMESTAMP" "$CPU_USAGE" "$RAM_USAGE" "$DISK_USAGE" >> "$LOG_FILE"

# CPU Alert
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "$TIMESTAMP ALERT: CPU Usage High ($CPU_USAGE%)" >> "$ALERT_FILE"
fi

# RAM Alert
if [ "$RAM_USAGE" -gt "$RAM_THRESHOLD" ]; then
    echo "$TIMESTAMP ALERT: RAM Usage High ($RAM_USAGE%)" >> "$ALERT_FILE"
fi

# Disk Alert
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "$TIMESTAMP ALERT: Disk Usage High ($DISK_USAGE%)" >> "$ALERT_FILE"
fi
