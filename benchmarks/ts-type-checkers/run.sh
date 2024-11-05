NO_COLOR=1
export NO_COLOR=1

echo $ARTIFACTS_FOLDER
echo $SOMETHING

echo "::group::Run tools"

function run_tool {
    OUTPUT="$(eval "$2" 2>&1 | sed $'s/\e\\[[0-9;:]*[a-zA-Z]//g')"
    echo "## $1

<details>
<summary>Output</summary>

\`\`\`
$OUTPUT
\`\`\`
</details>

" >> $GITHUB_STEP_SUMMARY
} 

run_tool "Ezno" "./ezno/target/release/ezno check demo.tsx --timings"
run_tool "Ezno (next)" "./ezno-next/target/release/ezno check demo.tsx --timings"
run_tool "TSC" "tsc --pretty --noEmit --skipLibCheck --jsx preserve --diagnostics demo.tsx"
# run_tool "STC" "./stc/target/release/stc test demo.tsx"

echo "::endgroup::"

echo "::group::Run benchmarks"

echo "## Benchmark files" >> $GITHUB_STEP_SUMMARY

# Ezno and TSC
echo "\`\`\`
$(hyperfine -i \
  './ezno/target/release/ezno check ./demo.tsx' \
  './ezno-next/target/release/ezno check ./demo.tsx' \
  'tsc --pretty --skipLibCheck --noEmit --jsx preserve ./demo.tsx' \
)
\`\`\`" >> $GITHUB_STEP_SUMMARY

echo "::endgroup::"
