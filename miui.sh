#!/bin/bash

# ANSI颜色代码
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # 恢复默认颜色

execute_script() {
  # 获取读写权限,给它权限
  termux-setup-storage
  echo -e "${GREEN}已获取读写权限${NC}"

  # 更新源
  pkg update
  echo -e "${GREEN}已更新源${NC}"

  # 安装python和nano
  pkg install python nano wget
  echo -e "${GREEN}已安装python、nano和wget${NC}"

  # 下载脚本
  wget https://raw.githubusercontent.com/CoverUp137/jiaoben/main/miui.py
  echo -e "${GREEN}已下载脚本${NC}"

  # 安装python依赖
  pip install requests -i https://pypi.tuna.tsinghua.edu.cn/simple
  echo -e "${GREEN}已安装python依赖${NC}"

  # 用户选择单账号或多账号
  echo -e "${YELLOW}请选择账号类型：${NC}"
  echo -e "1. 单账号"
  echo -e "2. 多账号"
  read -p "输入选项 (1 或 2): " account_type

  # 检查用户是否提供了有效的选项
  if [[ "$account_type" != "1" && "$account_type" != "2" ]]; then
    echo -e "${RED}无效的选项${NC}"
    exit 1
  fi

  if [ "$account_type" -eq 1 ]; then
    read -p "请输入手机号码: " mi_account
    read -p "请输入密码: " mi_password

    # 生成配置文件
    echo "export mi_account='$mi_account'" > config.sh
    echo "export mi_password='$mi_password'" >> config.sh
    echo "python3 miui.py" >> config.sh
    echo -e "${GREEN}已生成配置文件${NC}"
  
  elif [ "$account_type" -eq 2 ]; then
    read -p "请输入多个手机号码，用&分隔: " mi_accounts
    read -p "请输入多个密码，用&分隔: " mi_passwords

    # 生成配置文件
    echo "export mi_account='$mi_accounts'" > config.sh
    echo "export mi_password='$mi_passwords'" >> config.sh
    echo "python3 miui.py" >> config.sh
    echo -e "${GREEN}已生成配置文件${NC}"
  fi

  # 执行脚本
  sh config.sh
  echo -e "${YELLOW}开始执行脚本${NC}"

  # 最后添加的一句
  echo "以后每天只需要执行 sh config.sh 即可"
}

execute_script


