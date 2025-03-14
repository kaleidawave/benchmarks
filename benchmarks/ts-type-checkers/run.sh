NO_COLOR=1
export NO_COLOR=1

echo "## Example file \`demo.ts\`

<details>
<summary>Content</summary>

\`\`\`ts
$(cat demo.ts)
\`\`\`
</details>

" >> $GITHUB_STEP_SUMMARY

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

run_tool "TSC" "./tsc-go/built/local/tsgo tsc -pretty -noEmit -skipLibCheck demo.ts"
run_tool "Ezno" "./ezno/target/release/ezno check demo.ts --timings"

echo "::endgroup::"

# ---

echo "::group::Run benchmarks"

echo "## Benchmark files" >> $GITHUB_STEP_SUMMARY

echo "##### \`demo.ts\`

\`\`\`
$(hyperfine -w 10 -i \
  './ezno/target/release/ezno check ./demo.ts' \
  './tsc-go/built/local/tsgo tsc -skipLibCheck -pretty -noEmit ./demo.ts' \
  'tsc --pretty --skipLibCheck --noEmit ./demo.ts'
)
\`\`\`

##### \`large.ts\`

\`\`\`
$(hyperfine -w 10 -i \
  './ezno/target/release/ezno check ./large.ts' \
  './tsc-go/built/local/tsgo tsc -skipLibCheck -pretty -noEmit ./large.ts' \
  'tsc --pretty --skipLibCheck --noEmit ./large.ts'
)
\`\`\`
" >> $GITHUB_STEP_SUMMARY

echo "::endgroup::"

# ---

echo "::group::Run stuff I do not undertand"

echo "::group::ezno"
./ezno/target/release/ezno check --max-diagnostics 0 --timings ./demo.ts
echo "::endgroup::"

echo "::group::tsgo"
./tsc-go/built/local/tsgo tsc -skipLibCheck -noEmit ./demo.ts
./tsc-go/built/local/tsgo tsc -skipLibCheck -noEmit -singleThreaded ./demo.ts
./tsc-go/built/local/tsgo tsc -skipLibCheck -noEmit -singleThreaded ./demo.ts
echo "::endgroup::"

# ---

echo "::group::Run memory benchmarks"

### Valgrind
# valgrind --log-file="ezno-mem.txt" ./ezno/target/release/ezno check ./demo.ts
# valgrind --log-file="tsc-go-mem.txt" ./tsc-go/built/local/tsgo tsc -skipLibCheck ./demo.ts
# valgrind --log-file="tsc-mem.txt" tsc --pretty --skipLibCheck --noEmit ./demo.ts

# Valgrind

# <details>
# <summary>ezno memory</summary>

# \`\`\`
# $(cat ezno-mem.txt)
# \`\`\`
# </details>

# <details>
# <summary>tsc-go memory</summary>

# \`\`\`
# $(cat tsc-go-mem.txt)
# \`\`\`
# </details>

# <details>
# <summary>tsc memory</summary>

# \`\`\`
# $(cat tsc-mem.txt)
# \`\`\`
# </details>


echo "## Memory usage

<details>
<summary>Comparison</summary>

\`\`\`
$(./incredible-serious-memory-benchmark-tool \
  './ezno/target/release/ezno check ./large.ts' \
  './tsc-go/built/local/tsgo tsc -skipLibCheck ./large.ts' \
  'tsc --pretty --skipLibCheck --noEmit ./large.ts')
\`\`\`
</details>

" >> $GITHUB_STEP_SUMMARY

echo "::endgroup::"

echo "::endgroup::"
