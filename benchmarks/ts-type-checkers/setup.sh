# CORPUS

curl https://gist.githubusercontent.com/kaleidawave/81066f322ed574b3373e27770137013f/raw/b04dcc0bc60e6331008bdd578b98224cc07d5d42/all.tsx > demo.tsx

touch demo10.tsx

for i in {1..10}; do
    cat demo.tsx >> demo10.tsx
done

# TOOLS

# TYPESCRIPT (JS/NODE)
npm install typescript

# TYPESCRIPT (GOLANG)
npm install @typescript/native-preview-linux-x64

# EZNO
gh run download -R kaleidawave/ezno --pattern binary-LinuxX64-general-fixes-last
mv binary-LinuxX64-general-fixes-last/binary-LinuxX64-general-fixes-last ezno
chmod +x ./ezno

# Check all good

./ezno --help || true
./node_modules/typescript/lib/_tsc.js --help || true
./node_modules/@typescript/native-preview-linux-x64/lib/tsgo --help || true
