echo "### simple-json-parser: parse github-api.json (SDE)" > $GITHUB_STEP_SUMMARY
echo "" > $GITHUB_STEP_SUMMARY
depict count --format markdown --write-results-to $GITHUB_STEP_SUMMARY target/release/examples/parse github-api.json