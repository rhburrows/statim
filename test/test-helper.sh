project_dir=$(pwd)
test_dir="$project_dir/test"
quicki_cmd="$project_dir/quicki.sh"

load_fixtures() {
    cp -Rp $test_dir/fixtures/content .
}