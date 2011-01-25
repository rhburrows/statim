#!/bin/sh

STATIM_VERSION="0.0.1"
export STATIM_VERSION

dest_dir=$1
test -d $dest_dir || {
    mkdir -p $dest_dir
}

# TODO: make this smarter
markdown_cmd="markdown"

process_file() {
    case "$1" in
        *.md|*.markdown)
            process_markdown "$1"
            ;;
        *)
            process_static "$1"
            ;;
    esac
}

process_dir() {
    files="$(ls $1)"
    for file in $files
    do
        test -d "$1/$file" && {
            process_dir "$1/$file"
            continue
        }
 
        process_file "$1/$file"
    done

    final_dir=$(echo "$1" | sed -e "s/^content/$dest_dir/g")
    convert_links "$final_dir"
}

process_static() {
    dest=$(echo "$1" | sed -e "s/^content/$dest_dir/g")
    dir=$(dirname "$dest")

    test -d "$dir" || {
        mkdir "$dir"
    }

    cp "$1" "$dest"
}

process_markdown() {
    dest=$(echo "$1" | sed -e "s/^content/$dest_dir/" -e "s/markdown$/html/" -e "s/md$/html/")
    dir=$(dirname $dest)

    test -d "$dir" || {
        mkdir "$dir"
    }

    markdown "$1" > "$dest"
}

convert_links() {
    convert_files="$(ls $1/*.html)"

    for convert_file in $convert_files
    do
        to_camel_case "$(basename $convert_file)"
        echo "Link name $camel_cased" >> ../log.txt
        link="\\<a href=\\\"$(basename $convert_file)\\\"\\>$camel_cased\\<\\/a\\>"
        echo "Link $link" >> ../log.txt

        for other_file in $convert_files
        do
            test "$other_file" = "$convert_file" && {
                continue
            }

            sed -e "s/$camel_cased/$link/g" "$other_file" > "$other_file.tmp"
            echo "Sub for '$camel_cased' in '$other_file'"
            mv "$other_file.tmp" "$other_file"
        done
    done
}

awk_prog='BEGIN{ RS="_"; ORS=""} { print toupper(substr($1, 1, 1)) substr($1, 2) } END { print "\n" }'
to_camel_case() {
    camel_cased=$(echo "$1" | sed -e 's/\.html//' | awk "$awk_prog")
}

process_dir content