#!/bin/bash

# GOAL
#  - generate log files with directory sizes

# Check the number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 [PATH to parent directory] [PATH to results directory]"
    exit 1
fi

# Directory Paths - Make sure paths end with '/'
parent_dir=$1
out_log_dir=$2

# check last character and add a '/' to the end if its not there
end1=$((${#parent_dir}-1))
end2=$((${#out_log_dir}-1))

slash=/
if [ "${parent_dir:$end1:1}" != "$slash" ]; then 
  parent_dir="$parent_dir/"
fi

if [ "${out_log_dir:$end2:1}" != "$slash" ]; then 
  out_log_dir="$out_log_dir/"
fi

echo "Input Directory: $parent_dir"
echo "Output Directory: $out_log_dir"

# D1 output log files
out_prefix="log_parent_dir_sizes_"
out_file1="current_log_d1_parent_dir_sizes.txt"
file_tag=".txt"
timestamp=$(date +"%m-%d-%y")
output_file=$out_log_dir$out_prefix$timestamp$file_tag
output_file_current=$out_log_dir$out_file1

# D2 output log files
out_prefix2="log_d2_dir_sizes_"
out_file2="current_log_d2_parent_dir_sizes.txt"
output_file2=$out_log_dir$out_prefix2$timestamp$file_tag
output_file_current2=$out_log_dir$out_file2

# D1 - get parent directory sizes
du -m -d1 $parent_dir > $output_file
du -m -d1 $parent_dir > $output_file_current

# D2 - get all sub-directory sizes
du -m -d2 $parent_dir > $output_file2
du -m -d2 $parent_dir > $output_file_current2


echo ">>> DONE!"