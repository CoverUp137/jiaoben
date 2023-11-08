#!/bin/bash

# 获取读写权限,给它权限
termux-setup-storage
echo "已获取读写权限"

# 更新源
pkg update
echo "已更新源"

# 安装python和nano
pkg install python nano wget
echo "已安装python、nano和wget"

# 下载脚本
wget https://raw.githubusercontent.com/CoverUp137/jiaoben/main/miui.py
echo "已下载脚本"

# 安装python依赖
pip install requests -i https://pypi.tuna.tsinghua.edu.cn/simple
echo "已安装python依赖"

# 用户选择单账号或多账号
echo "请选择账号类型："
echo "1. 单账号"
echo "2. 多账号"
read -p "输入选项 (1 或 2): " account_type

if [ "$account_type" -eq 1 ]; then
  read -p "请输入手机号码: " mi_account
  read -p "请输入密码: " mi_password

  # 生成配置文件
  echo "export mi_account='$mi_account'" > config.sh
  echo "export mi_password='$mi_password'" >> config.sh
  echo "python3 miui.py" >> config.sh
  echo "已生成配置文件"
  
elif [ "$account_type" -eq 2 ]; then
  read -p "请输入多个手机号码，用&分隔: " mi_accounts
  read -p "请输入多个密码，用&分隔: " mi_passwords

  # 生成配置文件
  echo "export mi_account='$mi_accounts'" > config.sh
  echo "export mi_password='$mi_passwords'" >> config.sh
  echo "python3 miui.py" >> config.sh
  echo "已生成配置文件"
else
  echo "无效的选项"
  exit 1
fi

# 执行脚本
sh config.sh
echo "开始执行脚本"
