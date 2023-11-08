#!/bin/bash

# ANSI颜色代码
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # 恢复默认颜色


echo -e "${GREEN}等待10秒后开始执行脚本${NC}"
echo -e "${GREEN}接下来手机会请求获取读取权限,请点同意${NC}"
sleep 10

# 获取读写权限,给它权限
termux-setup-storage
echo -e "${GREEN}✅获取读写权限${NC}"

echo -e "${GREEN}接下来更新源${NC}"
echo -e "${GREEN}有y的选择y然后回车,没y的直接回车${NC}"
echo -e "${GREEN}脚本都放在github上,直链下载不了的话可能需要魔法网络${NC}"
sleep 15

# 更新源
pkg update
echo -e "${GREEN}✅已更新源${NC}"

# 安装python和nano
pkg install python nano wget
echo -e "${GREEN}✅已安装python、nano和wget${NC}"

# 下载脚本
wget https://raw.githubusercontent.com/CoverUp137/jiaoben/main/miui.py
echo -e "${GREEN}✅已下载脚本${NC}"

# 安装python依赖
pip install requests -i https://pypi.tuna.tsinghua.edu.cn/simple
echo -e "${GREEN}✅已安装python依赖${NC}"

# 用户选择单账号或多账号
echo -e "${YELLOW}😂请选择账号类型😂：${NC}"
echo -e "1. 单账号"
echo -e "2. 多账号"
read -p "输入选项 (1 或 2)然后回车: " account_type

if [ "$account_type" -eq 1 ]; then
  read -p "📱请输入小米手机号码,输入完回车: " mi_account
  read -p "📱请输入小米密码输入,完成后回车: " mi_password

  # 生成配置文件
  echo "export mi_account='$mi_account'" > config.sh
  echo "export mi_password='$mi_password'" >> config.sh
  echo "python3 miui.py" >> config.sh
  echo -e "${GREEN}已生成配置文件${NC}"
  
elif [ "$account_type" -eq 2 ]; then
  read -p "📱请输入多个手机号码，用&分隔,完成回车: " mi_accounts
  read -p "📱请输入多个密码，用&分隔,完成回车: " mi_passwords

  # 生成配置文件
  echo "export mi_account='$mi_accounts'" > config.sh
  echo "export mi_password='$mi_passwords'" >> config.sh
  echo "python3 miui.py" >> config.sh
  echo -e "${GREEN}✅已生成配置文件${NC}"
else
  echo -e "${RED}❌无效的选项${NC}"
  exit 1
fi

# 执行脚本
echo -e "${YELLOW}🏃‍♀️开始执行脚本🏃‍♀️${NC}"
sh config.sh
# 最后添加的一句
echo -e "${YELLOW}❤️以后每天只需要回到termux 并执行一次 sh config.sh即可❤️${NC}"
