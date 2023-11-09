#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' 


echo  "${YELLOW}🚀获取权限,第一次执行需要给读写权限,注意看手机屏幕跳出来的选项🚀${NC}"
echo  "${GREEN}开始获取读写权限${NC}"
termux-setup-storage

echo  "${GREEN}等待15秒${NC}"
sleep 15 
echo  "\n"
echo  "\n"

echo  "${YELLOW}😂是否要更新源？😂${NC}"
echo  "1. 更新源"
echo  "2. 跳过更新源"
read -p "输入选项 (1 或 2)然后回车 (默认为 1): " update_option
update_option=${update_option:-1}

if [ "$update_option" -eq 1 ]; then
  
  echo  "${GREEN}✅开始更新源${NC}"
  pkg update
else
  echo  "${YELLOW}❗已跳过更新源❗${NC}"
fi

echo  "\n"
echo  "\n"


echo  "${YELLOW}😂是否要安装Python？😂${NC}"
echo  "1. 安装Python和wget"
echo  "2. 跳过安装"
read -p "输入选项 (1 或 2)然后回车 (默认为 1): " install_option
install_option=${install_option:-1}

if [ "$install_option" -eq 1 ]; then
echo  "${GREEN}开始安装Python和wget${NC}"
  pkg install python wget
else
  echo  "${YELLOW}❗已跳过安装Python和wget❗${NC}"
fi

echo  "\n"
echo  "\n"


echo  "${YELLOW}😂是否要下载MIUI签到脚本？😂${NC}"
echo  "1. 下载脚本"
echo  "2. 跳过下载脚本"
read -p "输入选项 (1 或 2)然后回车 (默认为 1): " download_option
download_option=${download_option:-1}

if [ "$download_option" -eq 1 ]; then
echo  "${GREEN}开始下载脚本${NC}"
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/CoverUp137/jiaoben/main/miui.py  
else
  echo  "${YELLOW}❗已跳过下载脚本❗${NC}"
fi

echo  "\n"
echo  "\n"


echo  "${YELLOW}😂是否要安装Python依赖？😂${NC}"
echo  "1. 安装Python依赖"
echo  "2. 跳过安装Python依赖"
read -p "输入选项 (1 或 2)然后回车 (默认为 1): " install_dep_option
install_dep_option=${install_dep_option:-1}

if [ "$install_dep_option" -eq 1 ]; then
echo  "${GREEN}开始安装Python依赖${NC}"
  pip install requests -i https://pypi.tuna.tsinghua.edu.cn/simple
else
  echo  "${YELLOW}❗已跳过安装Python依赖❗${NC}"
fi

echo  "\n"
echo  "\n"

echo  "${YELLOW}😂请选择账号类型😂：${NC}"
echo  "1. 单账号"
echo  "2. 多账号"
read -p "输入选项 (1 或 2)然后回车 (默认为 1): " account_type
account_type=${account_type:-1}

if [ "$account_type" -eq 1 ]; then
  read -p "📱请输入小米手机号码,输入完回车: " mi_account
  read -p "📱请输入小米密码输入,完成后回车: " mi_password

  echo "export mi_account='$mi_account'" > mi.sh
  echo "export mi_password='$mi_password'" >> mi.sh
  echo "python3 miui.py" >> mi.sh
  echo  "${GREEN}已生成配置文件${NC}"
  
elif [ "$account_type" -eq 2 ]; then
  read -p "📱请输入多个手机号码，用&分隔,完成回车: " mi_accounts
  read -p "📱请输入多个密码，用&分隔,完成回车: " mi_passwords

  echo "export mi_account='$mi_accounts'" > mi.sh
  echo "export mi_password='$mi_passwords'" >> mi.sh
  echo "python3 miui.py" >> mi.sh
  echo  "${GREEN}✅已生成配置文件${NC}"
else
  echo  "${RED}❌无效的选项${NC}"
  exit 1
fi

echo  "${YELLOW}🏃‍♀️开始执行脚本🏃‍♀️${NC}"
sh mi.sh

echo  "${YELLOW}❤️以后每天只需要回到termux 执行一次命令: sh mi.sh 即可❤️${NC}"
