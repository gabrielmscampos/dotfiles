#!/bin/bash

if ! command -v nvidia-smi &> /dev/null; then
  exit 0
fi

# Check if any GPU is detected
if ! nvidia-smi > /dev/null 2>&1; then
  exit 0
fi

# Get used and total GPU memory and compute usage
# Do not use `utilization.memory` because it is reporting a
# the percent of time over the last sampling interval which
# memory is being actively read/written.
mem_used=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits | head -n1)
mem_total=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | head -n1)
mem_usage=$(echo "100 * $mem_used / $mem_total" | bc -l)
mem_usage_rounded=$(echo "$mem_usage + 0.5" | bc | cut -d'.' -f1)

echo "{\"text\": \"${mem_usage_rounded}% \", \"tooltip\": \"NVIDIA GPU memory usage\"}"
