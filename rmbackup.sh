#!/system/bin/sh
#cron: 0 13 * * * 
#new Env('删除青龙备份');

rm -rf /ql/backups/*.tar.gz

echo '删除完成!'

echo '备份脚本中的 QLBK_BACKUPS_PATH 使用默认值，删除备份才会生效'

echo '如修改了 QLBK_BACKUPS_PATH 的默认值，自己把这个脚本也改改'
