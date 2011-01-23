#!/bin/sh

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

process_dir content