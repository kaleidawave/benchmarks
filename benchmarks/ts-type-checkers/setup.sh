# Install hyperfine
brew install hyperfine

echo "::group::Get tools"

# TODO flow, hegel, install tools (or cache better), more

# echo "::group::Build STC"

# rustup toolchain install nightly-2023-06-20

# git clone https://github.com/dudykr/stc stc
# cd stc
# git reset --hard 693cf5a891c5580542811b906616f0c15d0dd0fc
# cd ..

# cargo +nightly-2023-06-20 build --manifest-path stc/crates/stc/Cargo.toml --no-default-features --locked

# ./stc/target/release/stc --help

# echo "::endgroup::"

echo "::group::Build Ezno (and demo.tsx)"
rustc --version
rustup toolchain install stable

# Main
git clone https://github.com/kaleidawave/ezno.git ezno -b main

cargo build --manifest-path ezno/Cargo.toml --release --bin ezno

# and new parser
git clone https://github.com/kaleidawave/ezno.git ezno-next -b merge-lexer
cargo build --manifest-path ezno-next/Cargo.toml --release --bin ezno

# cargo install --path ezno

./ezno/target/release/ezno info
./ezno/target/release/ezno-next info

echo "::group::Build demo files"
cargo run --manifest-path ezno/Cargo.toml \
    -p ezno-parser --example code_blocks_to_script ./ezno/checker/specification/specification.md \
    --comment-headers --out ./demo.tsx

cp ./demo.tsx $ARTIFACTS_FOLDER

echo "::endgroup::"

echo "::endgroup::"

echo "::group::Get TSC"

npm install -g typescript

echo "::endgroup"

echo "::endgroup"