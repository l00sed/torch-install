#!/bin/bash

#-------------------------------------------
# Neural Styles Install Script Part 1 - v1
# https://github.com/jcjohnson/neural-styles
#-------------------------------------------
# 3/31/2020
#===========================================

# Shows a spinner while another command is running. Randomly picks one of 12 spinner styles.
# @args command to run (with any parameters) while showing a spinner. 
#       E.g. ‹spinner sleep 10›

function shutdown() {
  tput cnorm # reset cursor
}
trap shutdown EXIT

function cursorBack() {
  echo -en "\033[$1D"
}

function spinner() {
  # make sure we use non-unicode character type locale 
  # (that way it works for any locale as long as the font supports the characters)
  local LC_CTYPE=C

  local pid=$1 # Process Id of the previous running command

  case $(($RANDOM % 12)) in
  0)
    local spin='⠁⠂⠄⡀⢀⠠⠐⠈'
    local charwidth=3
    ;;
  1)
    local spin='-\|/'
    local charwidth=1
    ;;
  2)
    local spin="▁▂▃▄▅▆▇█▇▆▅▄▃▂▁"
    local charwidth=3
    ;;
  3)
    local spin="▉▊▋▌▍▎▏▎▍▌▋▊▉"
    local charwidth=3
    ;;
  4)
    local spin='←↖↑↗→↘↓↙'
    local charwidth=3
    ;;
  5)
    local spin='▖▘▝▗'
    local charwidth=3
    ;;
  6)
    local spin='┤┘┴└├┌┬┐'
    local charwidth=3
    ;;
  7)
    local spin='◢◣◤◥'
    local charwidth=3
    ;;
  8)
    local spin='◰◳◲◱'
    local charwidth=3
    ;;
  9)
    local spin='◴◷◶◵'
    local charwidth=3
    ;;
  10)
    local spin='◐◓◑◒'
    local charwidth=3
    ;;
  11)
    local spin='⣾⣽⣻⢿⡿⣟⣯⣷'
    local charwidth=3
    ;;
  esac

  local i=0
  tput civis # cursor invisible
  while kill -0 $pid 2>/dev/null; do
    local i=$(((i + $charwidth) % ${#spin}))
    printf "%s" "${spin:$i:$charwidth}"

    cursorBack 1
    sleep .1
  done
  tput cnorm
  wait $pid # capture exit code
  return $?
}

echo "Getting sample images..."
wget -O marilyn.jpg "https://www.moma.org/media/W1siZiIsIjcwNjE5Il0sWyJwIiwiY29udmVydCIsIi1xdWFsaXR5IDkwIC1yZXNpemUgMjAwMHgyMDAwXHUwMDNlIl1d.jpg?sha=e054a39456dbaa70" 
wget -O eric.jpg "https://d1y8sb8igg2f8e.cloudfront.net/images/EricSchmidt008.original.jpg"
echo "Starting Style Transfer"
th neural_style.lua -content_image eric.jpg -style_image marilyn.jpg -gpu 0,1 -image_size 500 -output_image output.jpg -backend cudnn -cudnn_autotune &
spinner $!

