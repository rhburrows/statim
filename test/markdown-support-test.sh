source test/test-helper.sh

describe "Handles markdown files specially"

before() {
    test -d tmp || { 
        mkdir tmp
    }
    cd tmp
    load_fixtures
}

after() {
    cd .. && rm -r tmp
}

it_creates_html_files_from_md_files() {
    $statim_cmd dist
    test -f dist/md/short.html
    test ! -f dist/md/short.md
}

it_creates_html_files_from_markdown_files() {
    $statim_cmd dist
    test -f dist/markdown/long.html
    test ! -f dist/markdown/long.markdown
}

it_turns_camelcased_words_into_links_with_underscores_within_directories() {
    $statim_cmd dist
    link_pattern="<a href=\"linked_to_file_one.html\">LinkedToFileOne</a>" 
    grep -q "$link_pattern" dist/markdown/long.html
}