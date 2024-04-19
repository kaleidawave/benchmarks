# Install hyperfine
brew install hyperfine

export CURRENT_TARGET='trunk'
cargo build --bin codespan-reporting-benchmark --release
mv target/release/codespan-reporting-benchmark bin-trunk

echo "[patch.crates-io]" >> Cargo.toml
echo "codespan-reporting = { git = 'https://github.com/kaleidawave/codespan.git', branch = 'static-dispatch-writecolor' }" >> Cargo.toml

cargo update

export CURRENT_TARGET='fork'
cargo build --bin codespan-reporting-benchmark --release
mv target/release/codespan-reporting-benchmark bin-fork

