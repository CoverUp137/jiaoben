
//需要在青龙添加node依赖juejin-helper 例如：pnpm install juejin-helper 或 在青龙页面依赖中添加 juejin-helper
const JuejinHelper = require('juejin-helper');
//青龙的通知，不需要可注释或删除掉
const notify = require('./sendNotify');


//需要下载app手动玩一局海底挖宝游戏，才能开启游戏，否则会提示"用户未授权"

let ck = {  
    'juejin': ''
}

const mymsg =[];
let command = [];
const commandkey = ["R", "U", "L", "D"];
const cradNum=3 //上下左右卡片数量 （一般每局四种各有3块 如果四种都不止3块可以改这里）
const cradArr=cradNum*4 //路线长度
var NumbersOccur = function (val) {
  var newArrays = command.filter(function (item) {
    return item == val;
  });
  return newArrays.length < cradNum ? true : false;
};
//随机生成游戏路线防卡步 （如果没到每日上线时获取矿石一直为0的话 可以在游戏里手动换一下地图）
function randomCommand() {
  for (let i = 0; command.length < cradArr; i++) {
    let num = Math.floor(Math.random() * 4);
    let val = commandkey[num];
    if (NumbersOccur(val)) {
      command.push(val);
    }
  }
}
randomCommand();
async function juejingames(e) {
    const juejin = new JuejinHelper();
    await juejin.login(ck[e.user_id]);
    const seagold = juejin.seagold();

   let signTime= setInterval(async() => {
        await seagold.gameLogin(); // 登陆游戏
        let gameInfo = null;
        const info = await seagold.gameInfo(); // 游戏状态
        if (info.gameStatus === 1) {
            gameInfo = info.gameInfo; // 继续游戏
        } else {
            gameInfo = await seagold.gameStart(); // 开始游戏
        }
        await seagold.gameCommand(gameInfo.gameId, command); // 执行命令
        const result = await seagold.gameOver(); // 游戏结束
        mymsg.push(`本次获得${result.gameDiamond}矿石,今日上限${result.todayLimitDiamond},今日获取${result.todayDiamond} ${result.todayDiamond==result.todayLimitDiamond?'已上限运行结束':'等待下一次运行'}`);
         console.log(`本次获得${result.gameDiamond}矿石,今日上限${result.todayLimitDiamond},今日获取${result.todayDiamond} ${result.todayDiamond==result.todayLimitDiamond?'已上限运行结束':'等待下一次运行'}`);
        if(result.todayDiamond==result.todayLimitDiamond){
            clearInterval(signTime)
            juejin.logout();			
            //发送青龙通知
            try{
				let mm = mymsg.join('\n');
				notify.sendNotify('juejin', mm);
            }catch(e){
                console.log(e.message);
            }		
        }
    }, 12000)
 
}
async function auto(e) {
    const juejin = new JuejinHelper();
    await juejin.login(ck[e.user_id]);
    const growth = juejin.growth();
    try {
        let res = await growth.checkIn()
        let resp = await growth.getCurrentPoint();
        console.log(`签到成功!剩余矿石${resp}`);
        mymsg.push(`签到成功!剩余矿石${resp}`);
        await juejin.logout();
    } catch (error) {
        let resp = await growth.getCurrentPoint();
        let msg = [error.message, `当前剩余${resp}个矿石`]
        console.log(msg);
        mymsg.push(msg);
        await juejin.logout();
    }
}

console.log(`启动成功,首次运行请检查app.js是否配置ck`);
for (const key in ck) {		
	auto({ user_id: key })
	juejingames({ user_id: key })
}
    
