
#!/bin/bash

if ! command -v nvidia-smi &> /dev/null; then
  exit 0
fi

# Check if any GPU is detected
if ! nvidia-smi > /dev/null 2>&1; then
  exit 0
fi

# Get GPU utilization
util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | head -n1)

echo "{\"text\": \"${util}% \", \"tooltip\": \"NVIDIA GPU utilization\"}"
