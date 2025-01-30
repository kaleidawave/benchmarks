echo "::group::Setup"

gh release download -R denoland/deno -p "deno-x86_64-unknown-linux-gnu.*"
ls
unzip deno-x86_64-unknown-linux-gnu.zip
mv deno-x86_64-unknown-linux-gnu/deno deno
pwd >> "$GITHUB_PATH"
./deno install
curl https://www.bbc.co.uk/news > corpus.html

echo "::endgroup::"

output="### Performance output

\`\`\`shell
$(./deno bench comparison.ts)
\`\`\`"
echo output >> $GITHUB_STEP_SUMMARY