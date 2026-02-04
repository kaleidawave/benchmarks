gh repo clone kaleidwave/depict
cd depict && git checkout cli-improvements && cd ..
cargo install --path depict
depict install

gh repo clone kaleidwave/simple-json-parser .
git checkout improvements
git status
cargo b --release --example parse