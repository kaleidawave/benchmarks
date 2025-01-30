echo "::group::Setup"
gh release download -R denoland/deno -p "deno-x86_64-unknown-linux-gnu.*"
unzip deno-x86_64-unknown-linux-gnu.zip
mv deno-x86_64-unknown-linux-gnu deno
pwd >> "$GITHUB_PATH"
deno install
curl https://www.bbc.co.uk/news > corpus.html
echo "::endgroup::"

echo "### Performance output" >> $GITHUB_STEP_SUMMARY
echo "\`\`\`shell">> $GITHUB_STEP_SUMMARY
deno bench comparison.ts >> $GITHUB_STEP_SUMMARY
echo "\`\`\`">> $GITHUB_STEP_SUMMARY