# Work log
  # Accomplished so far: 
    # 1. get the json in the correct format for a single book.
    # 2. convert the json to csv
    # 3. upload json to spreadsheet to make sure the format looks good.
    # 4. add a second book, which would be a second json element and should be a second row on the db
    # 5. add a flag to reset the environment (simple: any arg)
    # 6. go through all subdirectories and returns absolute path of all mp3 files.
    # 7. pass each mp3 book to the converter that adds the book to the csv.

  # Remaining work:
    # 1. pass in file path as an argument. (remove reset or have a different flag trigger)
    # 2. scale to the full library and see if it works.
    # 3. rearange columns to a better format.
    # 4. update existing list instead of re-creating from scratch
#
convert-metadata-to-csv() {
  # reset files to rebuild the json which will later convert to csv.
  reset;
  # goes through all subdirectories and returns absolute path of all mp3 files.
  # get-mp3-data()
  mp3AbsolutePaths=$(find /Volumes/"Samsung USB"/ -name '*.mp3');
  echo "$mp3AbsolutePaths"
  # read 
  while read -r line; do convert-metadata-to-json-and-then-csv "$line"; done <<< "$mp3AbsolutePaths"
  echo "It worked! the above numbers show the number of books added, check books.csv for the final result!"
  # cleanup
  rm books.json temp.json
}

convert-metadata-to-json-and-then-csv() {
  local book=$1;
  local jqObject=$(ffprobe -v quiet -print_format json -show_format -show_streams "$book" 2>&1);

  local duration=$(echo "$jqObject" | jq '.format.duration');
  local bookJSON=$(echo "$jqObject" | jq --arg v "$duration" '.format.tags + {'duration': $v}' | jq 'del(.copyright)') 

  # precondition the json file being operated on should have a beginning value [] ... accomplished by reset in parent function.
  cat books.json | jq --argjson v "$bookJSON" '. += [$v]' > temp.json
  cp temp.json books.json

  # convert json to csv
  jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' books.json > books.csv

  cat books.json | jq length
};

reset() {
  rm books.json temp* books.csv;
  echo [] > books.json
}

# If any arguement is sent to the command reset all files.
if [ -z "$1" ]
then
  # example: bash get-mp3-data.bash
  convert-metadata-to-csv;
else 
  # example: get-mp3-data.bash anyvalue
  reset;
fi
