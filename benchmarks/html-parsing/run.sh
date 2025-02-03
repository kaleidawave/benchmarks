echo "::group::Setup"

gh release download -R denoland/deno -p "deno-x86_64-unknown-linux-gnu.*"
unzip deno-x86_64-unknown-linux-gnu.zip
pwd >> "$GITHUB_PATH"
./deno install
curl https://www.bbc.co.uk/news > ./corpus.html

echo "::endgroup::"

./deno bench --no-check -A benchmark.ts

echo "::debug::Run benchmark"

export NO_COLOR=1
CB='```'
OUTPUT="### Performance output

"$CB"shell
$(./deno bench --no-check -A benchmark.ts)
$CB"

echo "$OUTPUT" >> $GITHUB_STEP_SUMMARY