#!/bin/sh

function CREATE {
  sqlite3 ~/.captainslog/captainslog.db  "CREATE TABLE IF NOT EXISTS log (id INTEGER PRIMARY KEY,date TEXT, log TEXT);"
  #Get Date for Database
  DBDATE=$(sqlite3 ~/.captainslog/captainslog.db "SELECT datetime('now');")
  #Get Date and Time for Print Statement
  DATE=$(date '+%d-%b-%Y')
  TIME=$(date '+%r')
  #Print Prompt
  printf "Captain's Log: ${DATE} at ${TIME}\nLog: "
  #Read Description
  read DESCRIPTION
  #Replace single quotes with two single quotes because sqlite3 strings
  DESCRIPTION=${DESCRIPTION//\'/\'\'}
  #Add Entry to Database
  sqlite3 ~/.captainslog/captainslog.db  "INSERT INTO log (date, log) VALUES ('${DBDATE}', '${DESCRIPTION}');"
}

function PRINT {
  sqlite3 ~/.captainslog/captainslog.db "SELECT * FROM log"
}

function HELP {
  echo "-p to print, -h for help"
}

if [ $# == 0 ]
  then
  CREATE
  else
  while getopts ::ph FLAG; do
    case $FLAG in
    p)
      PRINT
      ;;
    h)
      HELP
      ;;
    \?)
      echo "Unrecognized!"
      HELP
      ;;
    esac
  done 
fi
