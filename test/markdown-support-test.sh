source test/test-helper.sh

describe "Handles markdown files specially"

before() {
    mkdir tmp && cd tmp
    load_fixtures
}

after() {
    cd .. && rm -r tmp
}

it_creates_html_files_from_md_files() {
    $quicki_cmd dist
    test -f dist/md/short.html
    test ! -f dist/md/short.md
}

it_creates_html_files_from_markdown_files() {
    $quicki_cmd dist
    test -f dist/markdown/long.html
    test ! -f dist/markdown/long.markdown
}