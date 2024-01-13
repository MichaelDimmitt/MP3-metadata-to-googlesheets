# cd /Volumes/Samsung\ USB/Audiobooks;
# pwd;
# ls;
# cd -;
# 

get-mp3-data() {
  local book="The Final Empire: Mistborn Book 1.mp3"
  local jqObject=$(ffprobe -v quiet -print_format json -show_format -show_streams /Volumes/"Samsung USB"/Audiobooks/"$book" 2>&1);
  local duration=$(echo "$jqObject" | jq '.format.duration');
  local bookJSON=$(echo "$jqObject" | jq --arg v "$duration" '.format.tags + {'duration': $v}' | jq 'del(.copyright)') 

  # precondition the json file being operated on should have a beginning value []
  # add book to json
  # temp file needs to be used because we cant write to our input file right away ... it gets currupted and becomes blank!
  cat books.json | jq --argjson v "$bookJSON" '. += [$v]' > temp.json
  cp temp.json books.json
  
  # convert json to csv
  jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' books.json > temp.csv
  
  cat books.json | jq length

};

# Accomplished so far: 
# 1. get the json in the correct format for a single book.
# 2. convert the json to csv
# 3. upload json to spreadsheet to make sure the format looks good.
# 4. add a second book, which would be a second json element and should be a second row on the db
# 5. add a flag to reset the environment (simple: any arg)

# Remaining work:
# 1. traverse subdirectories and build absolute paths (see file: traverse-folder.bash)
# 2. iterate subdirectories, probably using read, building giant json and susbsequent csv (or small json, and add rows to csv file each time.)
# 3. accept a directory as input so the solution is generalized and usable for others.

reset() {
  rm books.json temp*;
  echo [] > books.json
}

# If any arguement is sent to the command reset all files.
if [ -z "$1" ]
then
  # example: bash get-mp3-data.bash
  get-mp3-data;
else 
  # example: get-mp3-data.bash anyvalue
  reset;
fi
