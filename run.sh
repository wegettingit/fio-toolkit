#!/bin/bash

# FIO Runner Script by Johne
# Usage:
#   ./run.sh jobs/read-seq.fio
#   ./run.sh --batch jobs/

set -e

RESULTS_DIR="results"
mkdir -p "$RESULTS_DIR"

run_fio_job() {
  local jobfile="$1"
  local filename=$(basename "$jobfile" .fio)
  local timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
  local output_file="${RESULTS_DIR}/${filename}_${timestamp}.json"

  echo "▶ Running job: $jobfile"
  fio --output-format=json --output="$output_file" "$jobfile"
  echo "✅ Saved results to: $output_file"
}

if [[ "$1" == "--batch" && -d "$2" ]]; then
  for file in "$2"/*.fio; do
    [ -e "$file" ] || continue
    run_fio_job "$file"
  done
elif [[ -f "$1" ]]; then
  run_fio_job "$1"
else
  echo "❌ Usage:"
  echo "  ./run.sh jobs/read-seq.fio"
  echo "  ./run.sh --batch jobs/"
  exit 1
fi
add FIO runner script
