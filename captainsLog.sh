#!/bin/sh

#CREATE NEW ENTRY
  sqlite3 captainslog.db  "CREATE TABLE IF NOT EXISTS log (id INTEGER PRIMARY KEY,date TEXT, log TEXT);"
  #Get Date for Database
  DBDATE=$(sqlite3 captainslog.db "SELECT datetime('now');")
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
  sqlite3 captainslog.db  "INSERT INTO log (date, log) VALUES ('${DBDATE}', '${DESCRIPTION}');"

#DUMP DATABASE
