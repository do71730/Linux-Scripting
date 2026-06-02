#!/bin/bash

source monitor.conf

#log error to a file
log(){

    if [ ! -d "$LOGDIR" ]; then
        echo "Creating directory $LOGDIR"
        mkdir -p "$LOGDIR"
    fi

    if [ ! -f "$LOGFILE" ]; then
        echo "Creating file $LOGFILE"
        touch "$LOGFILE"
    fi
    echo "logging error into $LOGFILE"
    echo "$(date '+%Y-%m-%d %H:%M:%S' ) - $1" >> $LOGFILE
}

top_proccesses(){
    echo "TOP PROCESSES: CPU"
    ps aux --sort=-%cpu | head -n 6
    
    echo "TOP PROCESSES: MEMORY"
    ps aux --sort=-%mem | head -n 6
}

#take 2 argument $1 is the usage and $2 is percentage. Change Alert text color to read then back to normal
send_alert(){
    echo "${RED} ALERT: $1 usage exceed threshold! Current value: $2%${RESET}"
    log "ALERT $1 AT $2%"
}

while true; do
 
    clear #clear putputs. over crowding
    echo "Resources:"
 
    #fetch real time cpu stats then filter to the lines with "cpu",ignore case. Save % of user and CPU usage
    cpuUsage=$(top -bn1 | grep -i "Cpu(s)" | awk '{print $2 + $4}')
    echo "Current CPU usage: $cpuUsage%"
    
    cpuUsage=${cpuUsage%.*} #convert to int

    if ((cpuUsage >= CPU_THRESHOLD)); then 
        send_alert "CPU" "$cpuUsage"
    fi


    # Monitor memory usage, calculate %memory usage: used memory/total memory
    memoryUsage=$(free | awk '/Mem/ {printf("%3.1f", ($3/$2) * 100)}')

    echo "Current memory usage: $memoryUsage%"

    memoryUsage=${memoryUsage%.*}

    if ((memoryUsage >= MEMORY_THRESHOLD)); then
        send_alert "Memory" "$memoryUsage"
    fi

    # Monitor disk usage for root directory, usgae percentage column only
    diskUsage=$(df -h / | awk '/\// {print $(NF-1)}')

    diskUsage=${diskUsage%?} #remove %

    echo "Current disk usage: $diskUsage%"

    if ((diskUsage >= DISK_THRESHOLD)); then
        send_alert "Disk" "$diskUsage"
    fi

    top_proccesses

    sleep $INTERVAL #5 second intervals
done    
