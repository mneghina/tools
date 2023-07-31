#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 <character>"
  exit 1
fi

char="${1:0:1}"

binary=$(echo -n $char | xxd -b | awk '{print $2}')

part1="${binary:0:2}"
part2="${binary:2:6}"

part12="110000$part1"
part1_padding="110000"

part2_padded=$(printf "%06s" "$part2")

part2_padded="10$part2_padded"
part2_padding="10"

hex_part1=$(printf "%X" "$((2#$part12))")
hex_part2=$(printf "%X" "$((2#$part2_padded))")

ascii_part1=$(printf "\\x$hex_part1")
ascii_part2=$(printf "\\x$hex_part2")

echo -e "Original binary for $char: \033[32m$binary\033[0m"
echo -e "Overlong Binary: ${part1_padding}\033[32m${part1}\033[0m ${part2_padding}\033[32m${part2}\033[0m"
echo "Overlong Hexadecimal: $hex_part1 $hex_part2"
#echo "Second part (binary): $part2_padded"
echo "ASCII character: $ascii_part1 $ascii_part2)"

