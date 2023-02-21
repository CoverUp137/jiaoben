'''
功能：mt论坛签到
Date: 2023/02/21 
cron: 30 10 * * *
new Env('MT论坛每日签到');
'''
#青龙环境变量: MTCOOKIE
#填入完整cookies执行。

import os
import re
import requests
from notify import send

cookie = os.environ.get("MTCOOKIE")  # 从环境变量中获取 Cookie

def main():
    try:
        headers = {
            "cookie": cookie,
            "Referer": "https://bbs.binmt.cc/member.php?mod=logging&action=login&mobile=2"
        }
        res = requests.get("https://bbs.binmt.cc/k_misign-sign.html", headers=headers)
        formhash = re.search(r"formhash=(.+?)&", res.text)
        if formhash and "登录" not in res.text:
            signurl = f"https://bbs.binmt.cc/k_misign-sign.html?operation=qiandao&format=button&formhash={formhash.group(1)}&inajax=1&ajaxtarget=midaben_sign"
            res2 = requests.get(signurl, headers=headers)
            if "今日已签" in res2.text:
                msg = "今天已经签到过啦"
            elif "签到成功" in res2.text:
                msg1 = re.search(r"获得随机奖励.+?金币", res2.text).group()
                msg2 = re.search(r"已累计签到 \d+ 天", res2.text).group()
                msg = f"签到成功\n{msg1}\n{msg2}"
            else:
                msg = "签到失败!原因未知"
                print(res2.text)
        else:
            msg = "cookie失效"
        print(msg)
        send("【MT论坛】签到通知", msg + '\n仓库地址：https://github.com/CoverUp137/jiaoben.git')
    except Exception as e:
        print(e)
        print("签到接口请求出错")
        send("【MT论坛】签到通知", "签到接口请求出错" + '\n仓库地址：https://github.com/CoverUp137/jiaoben.git')

if __name__ == "__main__":
    main()
