/*
京喜特价版红包兑换
入口：京喜特价版--底部中间百元生活费--左上角金币进去兑换
cron "59 59 58 23 * * *" jd_hb.js
*/
//变量 JD_HB
// 脚本无通知,需要通知自己调用sendNotify.js
const os = require('os');
const axios = require('axios');
const querystring = require('querystring');

const cookies = process.env.JD_HB.split('&');

const url = 'https://api.m.jd.com/api';
const headers = {
  'Host': 'api.m.jd.com',
  'x-rp-client': 'h5_1.0.0',
  'content-type': 'application/x-www-form-urlencoded',
  'user-agent': 'jdapp;iPhone;11.0.2;;;Mozilla/5.0 (iPhone; CPU iPhone OS 13_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148;supportJDSHWK/1',
  'origin': 'https://gold.jd.com',
  'x-requested-with': 'com.jd.jdlite',
  'referer': 'https://gold.jd.com/',
};

const data = {
  'functionId': 'MyAssetsService.execute',
  'appid': 'jx_h5',
  'channel': 'jxh5',
  'client': 'jxh5',
  // hongBaoOrder定义 6是240元 5是8元，4是5元 3是3元 2是1元  1是0.3元
  // 红包每日限量数量: 240元1个 8元50个, 5元50个 3元200个 1元1000个
  'body': '{"method":"cashOutBySendHongBao","data":{"hongBaoOrder":5,"type":1}}',
};

async function main() {
  for (let i = 0; i < 5; i++) { // 请求次数,默认5次,按需修改
    for (let j = 0; j < cookies.length; j++) { 
      headers.cookie = cookies[j];
      const response = await axios.post(url, querystring.stringify(data), { headers });

      const pt_pin = cookies[j].match(/pt_pin=([^;]+)/)[1];

      console.log(`账号${j + 1}: ${pt_pin}`);
      console.log(response.data);
      await sleep(500); // 每个账号请求间隔延迟500毫秒,按需修改
    }
    console.log(`第${i + 1}次请求完成`);
  }
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

main();
