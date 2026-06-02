# Monitoring System

This script monitors the current CPU, Memory, and Disk usage on a computer. When any usage goes over its threshold, it triggers a function that outputs a color‑coded warning to the terminal and logs that warning to a file. The script also checks whether the log directory and log file already exist; if they don’t, it creates them and then writes or appends the log entry.

On top of that, the script displays the top six CPU‑heavy and memory‑heavy processes.

## File and Directory Overview

- **monitor.conf**  
  Contains constant variables such as thresholds, log directory, log file path, colors, and interval settings.

- **system_monitor.sh**  
  The main script that reads the config file and performs monitoring.

  It includes:
  1. **`log()`**  
     Ensures the log directory and file exist. Creates them if needed, then appends log entries.
  
  2. **`top_processes()`**  
     Displays the top CPU and memory consuming processes.
  
  3. **`send_alert()`**  
     Prints a colored alert message when a threshold is exceeded and logs the event.

## Commands Used

Below are the main Linux commands used throughout this script:

- `top -bn1`: grabs a single snapshot of real‑time CPU stats  
- `grep`: filters out specific lines from command output  
- `awk`: extracts fields and performs percentage calculations  
- `free`: checks memory usage  
- `df -h /`: checks disk usage on the root directory  
- `ps aux --sort`: lists and sorts processes by CPU or memory usage  
- `head -n 6`: shows the top 6 results from a list  
- `mkdir -p`: creates the log directory if it doesn’t already exist  
- `touch`: creates the log file if it’s missing  
- `echo`: prints messages and writes log entries  
- `sleep`: controls how often the script refreshes  
- `source`: loads variables from the config file  


## How to Run
1. Clone a copy of this repository.
2. Make system_monitor.sh executable: `chmod +x system_monitor.sh`
3. (Optional) Edid monitor.conf to customize:
- Thresholds
- Log file location
- Refresh Interval
4. run `./system_monitor.sh`
   - The script will continuously display system resource usage and log alerts when thresholds are exceeded.

