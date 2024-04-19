echo "Trunk:"

./bin-trunk 2>/dev/null

./bin-trunk 2>&1 | tail -n 1

echo "Fork:"

./bin-fork 2>/dev/null

./bin-fork 2>&1 | tail -n 1

echo "Co"

echo "\`\`\`shell
// Comparison using 'hyperfine' 1
$(hyperfine -i "bin-trunk" "bin-fork")

// Comparison using 'hyperfine' 2
$(hyperfine -i "bin-trunk" "bin-fork")

// Comparison using 'hyperfine' 3
$(hyperfine -i "bin-trunk" "bin-fork")

// Trunk (existing)
$(./bin-trunk 2>/dev/null)

// Fork (new)
$(./bin-fork 2>/dev/null)
\`\`\`" >> $GITHUB_STEP_SUMMARY

