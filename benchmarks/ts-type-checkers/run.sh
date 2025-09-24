echo "ezno demo"

./ezno check demo.tsx --timings

echo "ezno demo10"

./ezno check demo10.tsx --timings

echo "typescript (node) demo"

node ./node_modules/typescript/lib/_tsc.js --noEmit --jsx preserve --skipLibCheck --diagnostics demo.tsx

echo "typescript (node) demo10"

node ./node_modules/typescript/lib/_tsc.js --noEmit --jsx preserve --skipLibCheck --diagnostics demo10.tsx

echo "typescript (tsgo) demo"

./node_modules/@typescript/native-preview-linux-x64/lib/tsgo --noEmit --jsx preserve --skipLibCheck --diagnostics demo.tsx

echo "typescript (tsgo) demo10"

./node_modules/@typescript/native-preview-linux-x64/lib/tsgo --noEmit --jsx preserve --skipLibCheck --diagnostics demo10.tsx

echo "comparison demo"
        
hyperfine -N -i './ezno check demo.tsx' './node_modules/@typescript/native-preview-linux-x64/lib/tsgo --noEmit --jsx preserve --skipLibCheck demo.tsx' 'node ./node_modules/typescript/lib/_tsc.js --noEmit --jsx preserve --skipLibCheck demo.tsx' >> "$GITHUB_OUTPUT"

echo "comparison demo10"

hyperfine -N -i './ezno check demo10.tsx' './node_modules/@typescript/native-preview-linux-x64/lib/tsgo --noEmit --jsx preserve --skipLibCheck demo10.tsx' 'node ./node_modules/typescript/lib/_tsc.js --noEmit --jsx preserve --skipLibCheck demo10.tsx' >> "$GITHUB_OUTPUT"
