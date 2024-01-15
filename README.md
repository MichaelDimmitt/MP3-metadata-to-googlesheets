## Why
I am doing this so I can make a google sheet to sort and filter my audio books

## MP3-metadata-to-googlesheets
1. Run the script passing telling as an argument the directory that either the mp3 files or contains the subfolders with the mp3 files.
2. Books.csv gets generated
3. Follow google sheets instructions
    1. Make a new google sheet
    2. Click File - Import - Upload
    3. Drag in Books.csv and click confirm.
    4. ... now wait for it to loads and you should now see all of the books for viewing filtering and sorting!

You may need to use detox: to fix file names before running this program.
```bash
# example usage:
# detox -r /Volumes/Samsung\ USB/
```

## Dependencies
ffmpeg - and ffprobe which comes as part of ffmpeg
find - native to macOS and most linux distros.

detox - fix bad file names. (downloadable on mac and linux not sure with windows)
https://github.com/dharple/detox

## Helpful Links:
https://askubuntu.com/a/754922/684192
https://stackoverflow.com/questions/34745451/passing-arguments-to-jq-filter
https://stackoverflow.com/a/47024050/5283424
https://unix.stackexchange.com/questions/460985/jq-add-objects-from-file-into-json-array

I also used `tldr jq` to get a high level understanding of jq  
https://github.com/tldr-pages/tldr

https://how.wtf/add-new-element-to-json-array-with-jq.html
