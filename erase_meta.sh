#!/bin/sh
file_picker() {
    FILE=`zenity --file-selection --title="Select a File"`

    case $? in
            0)
                echo "\"$FILE\" selected."
                $(exiftool -j $FILE |
                tr ',' ' ' |
                tr '"' ' ' |
                tail -n +4 |
                head -n -1 |
                zenity --text-info \
                    --width=650 \
                    --height=400)
                res=$?
                if [ $res -eq 0 ]; then
                    exiftool -all:all=  \
                        $FILE
                    rm "$FILE"_original
                    echo 'borrrar meta'
                fi
                ;;
            1)
                echo "No file selected."
                ;;
            -1)
                echo "An unexpected error has occurred."
                ;;
    esac
}
main() {
    zenity --question 
}
while true; do
  ans=$(zenity --info --title 'Metadata Eraser for PDF' \
        --text 'Wanna erase any meta?' \
        --width=350 \
        --height=100 \
        --ok-label 'Yes')
  rc=$?
  if [ $rc -eq 1 ]; then 
    break
  fi
  file_picker
done
echo 'Thank you'