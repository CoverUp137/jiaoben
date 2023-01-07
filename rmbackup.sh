#!/system/bin/sh
""
功能：自动备份qinglong基本文件至阿里云盘
cron: 0 1 * * *
new Env('删除青龙备份');
""
rm -rf /ql/backups/*.tar.gz