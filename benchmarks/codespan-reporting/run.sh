echo "\`\`\`shell
$(hyperfine -i "bin-trunk" "bin-fork")

// Trunk (existing)
$(./bin-trunk 2>/dev/null)

// Fork (new)
$(./bin-fork 2>/dev/null)
\`\`\`" >> $GITHUB_STEP_SUMMARY

echo "Trunk:"

./bin-trunk 2>/dev/null
./bin-trunk.exe 2>&1 | tail -n 1

echo "Fork:"

./bin-fork 2>/dev/null
./bin-fork.exe 2>&1 | tail -n 1
