#!/bin/bash

nav=$1
#next=`osascript -e 'tell application "Spotify" to next track'`
#pause=`osascript -e 'tell application "Spotify" to pause track'`
#artist=`osascript -e 'tell application "Spotify" to artist of current track as string'`
#track=`osascript -e 'tell application "Spotify" to name of current track as string'`
#random=`osascript -e 'tell application "Spotify" to play'`

next() {
    osascript -e 'tell application "Spotify" to next track'
}

pause() {
    osascript -e 'tell application "Spotify" to pause track'
}

play() {
    osascript -e 'tell application "Spotify" to play'
}

songinfo () {
  state=`osascript -e 'tell application "Spotify" to player state as string'`;
  if [ $state = "playing" ]; then
    artist=`osascript -e 'tell application "Spotify" to artist of current track as string'`;
    track=`osascript -e 'tell application "Spotify" to name of current track as string'`;

    echo "$artist - $track";
  fi
}

progressbar()
{
echo -ne '#####                  (33%)\r'
sleep .25
echo -ne '#############          (66%)\r'
sleep .4
echo -ne '#######################(100%)\r'
echo -ne '\n'
}


options='USAGE: spotcrl [$ARG] \n\nPlease provide me a valid argument. \n Current Options include: \n     pause: Pause your current track \n     next: Change to next track    \n play:play current track'
if [[ $nav == '' && $nav != 'next' && $nav != 'pause' && $nav != 'play' ]]; then
    echo -e "You didn't enter a valid command, dummy"
    echo -e $options
    exit 65
elif [[ $nav == 'next' ]]; then
   echo -e "Skipping..."
   songinfo
   next
   progressbar
   echo -e "Now Playing..."
   songinfo
elif [[ $nav == 'pause' ]]; then
    pause
    progressbar
    echo -e "Paused:"
    songinfo
elif [[ $nav == 'play' ]]; then
    play
    progressbar
    echo -e "Playing:"
    songinfo
fi
exit 0
