gh repo clone kaleidawave/depict
cd depict 
git checkout cli-improvements
cargo build
mv target/debug/depict ~
cd ~

gh repo clone kaleidawave/simple-json-parser
cd simple-json-parser
git checkout improvements
cargo b --release --example parse
mv target/release/examples/parse ~