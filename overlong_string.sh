#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 <string>"
  exit 1
fi

input_string="$1"
ascii_final= " "
hex_final=""

for (( i=0; i<${#input_string}; i++ )); do

  char="${input_string:i:1}"
  
  binary=$(echo -n $char | xxd -b | awk '{print $2}')

  part1="${binary:0:2}"
  part2="${binary:2:6}"

  part1_original="$part1"
  part1="110000$part1"
  part1_padding="110000"

  part2_padded=$(printf "%06s" "$part2")

  part2_padded="10$part2_padded"
  part2_padding="10"

  hex_part1=$(printf "%X" "$((2#$part1))")
  hex_part2=$(printf "%X" "$((2#$part2_padded))")

  ascii_part1=$(printf "\\x$hex_part1")
  ascii_part2=$(printf "\\x$hex_part2")

  hex_final+="${hex_part1}${hex_part2} "
  ascii_final+="${ascii_part1}${ascii_part2}"

  echo -e "Original binary for \033[31m${char}\033[0m: \033[32m${part1_original}\033[0m\033[94m${part2}\033[0m"
  echo -e "Overlong Binary: ${part1_padding}\033[32m${part1_original}\033[0m ${part2_padding}\033[94m${part2}\033[0m"
  echo "Overlong Hexadecimal: ${hex_part1}${hex_part2}"
#echo "Second part (binary): $part2_padded"
  echo "----------------------"
done
echo "Hex string: $hex_final "
echo "String: $input_string \\n" >> output
echo "$hex_final \\n" >> output
echo "$ascii_final \\n" >> output
echo "-----------------------\\n\\n" >> output
