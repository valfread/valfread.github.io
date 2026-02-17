#!/bin/bash

# 1. 备份源码到 main 分支
echo "正在备份源码到 main 分支..."
git add .
git commit -m "Site update: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main

# 2. 清理旧文件并生成静态网页
echo "正在重新生成静态网页..."
rm -rf public
hugo

# 3. 部署到 deploy 分支
echo "正在发布到 deploy 分支..."
cd public
git add -f .
git commit -m "Deploy update: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin deploy --force

# 4. 完成
cd ..
echo "🎉 恭喜！博客已成功更新并备份。"
read -p "按回车键退出..."