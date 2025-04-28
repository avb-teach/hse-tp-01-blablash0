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

find_command="find \"$input_dir\" -type f"
if [ -n "$max_depth" ]; then
    find_command="find \"$input_dir\" -maxdepth $max_depth -type f"
fi

eval "$find_command" |
while read -r file; do
    base_name=$(basename "$file")
    name="${base_name%.*}"
    ext="${base_name##*.}"

    if [ "$name" = "$ext" ]; then
  # Файл без расширения
      target="$output_dir/$name"
    else
      target="$output_dir/$name.$ext"
    fi

    counter=1
    while [ -e "$target" ]; do
      if [ "$name" = "$ext" ]; then
        target="$output_dir/${name}_$counter"
      else
        target="$output_dir/${name}_$counter.$ext"
      fi
      counter=$((counter + 1))
    done

    cp "$file" "$target"

done
# Скрипт для копирования файлов без структуры директорий
