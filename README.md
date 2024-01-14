## Why
I am doing this so I can make a google sheet to sort and filter my audio books

## MP3-metadata-to-googlesheets
1. Run the script passing telling as an argument the directory that either the mp3 files or contains the subfolders with the mp3 files.
2. Books.csv gets generated
3. Make a new google sheet, click File - Import - Upload - drag in Books.csv ... now you have all of the books for sorting!

## dependencies
ffmpeg - and ffprobe which comes as part of ffmpeg

## helpful links:
https://askubuntu.com/a/754922/684192
https://stackoverflow.com/questions/34745451/passing-arguments-to-jq-filter
https://stackoverflow.com/a/47024050/5283424
https://unix.stackexchange.com/questions/460985/jq-add-objects-from-file-into-json-array

I also used `tldr jq` to get a high level understanding of jq  
https://github.com/tldr-pages/tldr

https://how.wtf/add-new-element-to-json-array-with-jq.html
