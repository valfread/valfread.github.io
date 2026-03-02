#!/bin/bash

# 1. 备份源码到 main 分支
echo "正在备份源码到 main 分支..."
git add .
git commit -m "Site source update: $(date +'%Y-%m-%d %H:%M:%S') new post and updates"
git push origin main

# 2. 清理旧文件并重新生成静态网页
echo "正在重新生成静态网页..."
rm -rf public
hugo

# 3. 部署到 deploy 分支 (重新初始化模式)
echo "正在重新建立部署连接并发布..."
cd public
git init
git remote add origin https://github.com/valfread/valfread.github.io.git
git checkout -b deploy
git add -f .
git commit -m "Site deploy: $(date +'%Y-%m-%d %H:%M:%S')"

# 强制覆盖线上 deploy 分支，确保 RSS 和内容绝对最新
git push origin deploy --force

# 4. 完成
cd ..
echo "🎉 完美！博客已成功更新，RSS 链接和 Banner 均已就绪。"
read -p "按回车键退出..."