npm run build
echo $1
scp -o "StrictHostKeyChecking=no" -r ./dist/* $1:~/client/
