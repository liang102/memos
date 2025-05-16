#!/bin/bash

# 安装七牛云命令行工具
yum -y install wget unzip
wget https://devtools.qiniu.com/qshell-linux-x64-v2.4.0.zip
sleep 10
unzip qshell-linux-x64-v2.4.0.zip
chmod +x qshell

# 配置七牛云
./qshell account $QINIU_ACCESS_KEY $QINIU_SECRET_KEY

# 从七牛云下载数据库（如果存在）
./qshell get $QINIU_BUCKET memos.db /tmp/data/memos.db || touch /tmp/data/memos.db

# 构建 Memos
npm install
npm run build

# 部署完成后上传数据库到七牛云
./qshell put $QINIU_BUCKET memos.db /tmp/data/memos.db
