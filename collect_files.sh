#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 /path/to/input_dir /path/to/output_dir [--max_depth N]"
    exit 1
fi

input_dir="$1"
output_dir="$2"
max_depth=""

if [ "$#" -eq 4 ] && [ "$3" == "--max_depth" ]; then
    max_depth="$4"
fi

if [ ! -d "$input_dir" ]; then
    echo "Input directory does not exist: $input_dir"
    exit 1
fi

mkdir -p "$output_dir"

find_cmd=(find "$input_dir" -type f)
if [ -n "$max_depth" ]; then
    find_cmd=(find "$input_dir" -maxdepth "$max_depth" -type f)
fi

"${find_cmd[@]}" | while read -r filepath; do
    rel_path="${filepath#$input_dir/}" 
    target_path="$output_dir/$rel_path"

    mkdir -p "$(dirname "$target_path")"
    cp "$filepath" "$target_path"
done
