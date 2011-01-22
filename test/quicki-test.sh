source test/test-helper.sh

describe "quicki tests"

before() {
    mkdir tmp && cd tmp
    load_fixtures
}

after() {
    cd .. && rm -r tmp
}

it_copies_html_files_from_the_root_directory() {
    $quicki_cmd dist
    test -f dist/top.html
}