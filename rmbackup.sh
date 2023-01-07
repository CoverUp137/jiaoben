#!/system/bin/sh
#cron: 0 1 * * * 
#new Env('删除青龙备份');

rm -rf /ql/backups/*.tar.gz

echo '删除完成!'

echo '备份脚本中的 QLBK_BACKUPS_PATH 使用默认值，删除备份才会生效'

echo '修改了 QLBK_BACKUPS_PATH 的默认值，记得更改 删除备份 脚本中的路径代码'
