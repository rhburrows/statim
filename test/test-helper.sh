project_dir=$(pwd)
test_dir="$project_dir/test"
statim_cmd="$project_dir/statim.sh"

load_fixtures() {
    cp -Rp $test_dir/fixtures/content .
}