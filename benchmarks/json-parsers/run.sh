# Setup

gh repo clone kaleidwave/depict
cd depict && git checkout cli-improvements && cd ..
cargo install --path depict
depict install

# JSON

gh repo clone kaleidwave/simple-json-parser .
git checkout improvements
git status
cargo b --release --example parse

echo "### simple-json-parser: parse github-api.json (SDE)" > $GITHUB_STEP_SUMMARY
echo "" > $GITHUB_STEP_SUMMARY
depict count --format markdown --write-results-to $GITHUB_STEP_SUMMARY target/release/examples/parse github-api.json