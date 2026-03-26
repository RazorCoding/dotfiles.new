#!/bin/bash

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# Generate sed dict
i=0
while [ $i -lt ${#bar} ]; do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i + 1))
done

# Setup cava config and FIFO
config_file="/tmp/polybar_cava_config"
fifo="/tmp/cava_pipe"

# Create config
cat > "$config_file" <<EOF
[general]
bars = 18

[output]
method = raw
raw_target = $fifo
data_format = ascii
ascii_max_range = 7
EOF

# Cleanup function
cleanup() {
    [[ -n "$CAVA_PID" ]] && kill "$CAVA_PID" 2>/dev/null
    [[ -p "$fifo" ]] && rm -f "$fifo"
}
trap cleanup EXIT

# Create FIFO
rm -f "$fifo"
mkfifo "$fifo"

# Launch cava writing to the FIFO
cava -p "$config_file" &
CAVA_PID=$!

# Read from FIFO
while read -r line; do
    echo "$line" | sed "$dict"
done < "$fifo"

