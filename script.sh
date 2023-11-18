#!/bin/bash
if test -f node_modules; then
rm -r node_modules
fi
#Measure npm setup
start=$(date +%s)
npm i
npm run build
npm run start &
for i in {1..50}
do
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000)
if [ "$response" -eq 200 ]; then
kill -9 $(lsof -i:3000 -t)
else
sleep 0.1
fi
done
end=$(date +%s)
echo "Time for npm: $(($end-$start)) seconds"


if test -f node_modules; then
rm -r node_modules
fi
#Measure yarn setup
start=$(date +%s)
yarn i
yarn run build
yarn run start &
for i in {1..50}
do
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000)
if [ "$response" -eq 200 ]; then
kill -9 $(lsof -i:3000 -t)
else
sleep 0.1
fi
done
end=$(date +%s)
echo "Time for yarn: $(($end-$start)) seconds"
