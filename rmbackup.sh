#!/system/bin/sh
#cron: 0 1 * * * 
#new Env('删除青龙备份');

rm -rf /ql/backups/*.tar.gz

echo '删除完成'
