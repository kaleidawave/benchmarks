echo "::group::Setup"

gh release download -R denoland/deno -p "deno-x86_64-unknown-linux-gnu.*"
unzip deno-x86_64-unknown-linux-gnu.zip
pwd >> "$GITHUB_PATH"
./deno install
curl https://www.bbc.co.uk/news > ./corpus.html

echo "::endgroup::"

echo "::group::LS"
ls
echo "::endgroup::"

output="### Performance output

\`\`\`shell
$(./deno bench --no-check -A benchmark.ts)
\`\`\`"
echo output >> $GITHUB_STEP_SUMMARY