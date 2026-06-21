# Linux System Monitoring Script

A Bash-based Linux monitoring solution that tracks CPU, memory, and disk utilization, generates alerts for high resource consumption, and stores system metrics in a structured log format.

## Project Overview

This project demonstrates Linux administration, shell scripting, observability, logging, automation, and troubleshooting practices commonly used by DevOps Engineers and System Administrators.

## Features

* Monitor CPU usage
* Monitor RAM usage
* Monitor Disk usage
* Store metrics in log files
* Generate alerts based on configurable thresholds
* Automated directory creation
* Cron-compatible for scheduled monitoring

## Technologies Used

* Linux
* Bash Shell Scripting
* Cron
* awk
* grep
* df
* free
* top

## Project Structure

```text
linux-system-monitoring-script/
│
├── monitor.sh
├── logs/
│   └── system_usage.log
│
├── alerts/
│   └── alert.log
│
└── README.md
```

## Monitoring Metrics

### CPU Usage

Collected using:

```bash
top -bn1
```

### RAM Usage

Collected using:

```bash
free
```

### Disk Usage

Collected using:

```bash
df -h
```

## Alert Thresholds

Current thresholds:

```bash
CPU_THRESHOLD=80
RAM_THRESHOLD=80
DISK_THRESHOLD=80
```

Alerts are written to:

```text
alerts/alert.log
```

## Running the Script

Make executable:

```bash
chmod +x monitor.sh
```

Execute:

```bash
./monitor.sh
```

## Schedule Using Cron

Run every 5 minutes:

```bash
crontab -e
```

Add:

```bash
*/5 * * * * /path/to/monitor.sh
```

## Sample Output

### System Usage Log

```text
Timestamp            CPU(%)    RAM(%)    Disk(%)
2026-06-21 10:00:01  25        40        60
2026-06-21 10:05:01  32        43        60
```

### Alert Log

```text
2026-06-21 10:10:01 ALERT: CPU Usage High (85%)
```

---

# Challenges Faced & Solutions

## Issue 1: PowerShell Interpreting Bash Syntax

### Problem

Attempted to create and execute a Bash script inside Windows PowerShell.

Errors included:

```text
Missing '(' after 'if'
Missing file specification after redirection operator
Unexpected token
```

### Root Cause

PowerShell syntax differs from Bash syntax and cannot interpret shell script commands directly.

### Solution

Switched from PowerShell to Git Bash and later to Ubuntu WSL for Linux-compatible execution.

---

## Issue 2: Missing Linux Commands in Git Bash

### Problem

The monitoring script depended on:

```bash
top
free
```

Git Bash returned:

```text
which: no top
which: no free
```

### Root Cause

Git Bash does not provide a full Linux environment.

### Solution

Executed the project inside Ubuntu WSL where all required Linux utilities were available.

---

## Issue 3: Running Inside Docker Desktop Instead of Ubuntu WSL

### Problem

Initially opened Docker Desktop's Linux environment.

Observed:

```bash
cat /etc/os-release
```

Output:

```text
PRETTY_NAME="Docker Desktop"
```

Windows drives were not available under:

```text
/mnt/c
/mnt/f
```

### Solution

Exited Docker Desktop shell and launched Ubuntu WSL.

---

## Issue 4: Shell Script Would Not Execute

### Problem

Execution failed with:

```text
./monitor.sh: cannot execute: required file not found
```

### Root Cause

The script contained Windows CRLF line endings.

Detected using:

```bash
cat -A monitor.sh
```

Output contained:

```text
^M
```

### Solution

Converted line endings:

```bash
sed -i 's/\r$//' monitor.sh
```

After conversion the script executed successfully.

---

## Key Learning Outcomes

* Linux Shell Scripting
* Resource Monitoring
* Linux File Permissions
* WSL Administration
* Bash Troubleshooting
* Windows vs Linux Line Endings
* Cron Automation
* Observability Fundamentals
* DevOps Debugging Practices

## Future Enhancements

* Email Alerts
* Slack Notifications
* HTML Dashboard
* Prometheus Integration
* Grafana Dashboard
* CSV Export
* Top Process Monitoring
* Log Rotation Automation
