source test/test-helper.sh

describe "Tests for non-special filetypes"

before() {
    mkdir tmp && cd tmp
    load_fixtures
}

after() {
    cd .. && rm -r tmp
}

it_copies_files_from_the_root_directory() {
    $quicki_cmd dist
    test -f dist/top.html
    test -f dist/stylesheet.css
}

it_copies_files_in_nested_directories() {
    $quicki_cmd dist
    test -f dist/one/inner.html
    test -f dist/one/script.js
    test -f dist/one/two/inner-inner.html
}

it_puts_the_resulting_project_in_the_directory_named_for_the_first_arg() {
    $quicki_cmd other
    test -d other
    test ! -d dist
}