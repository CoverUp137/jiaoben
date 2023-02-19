import os
import shutil
from datetime import datetime
from notify import send

folder_path = '/ql/backups/'

# 获取文件夹下所有以.tar.gz为后缀名的文件
files = [f for f in os.listdir(folder_path) if f.endswith('.tar.gz')]

# 检查文件是否存在，存在则删除
if len(files) > 0:
    deleted_files = []
    for file in files:
        file_path = os.path.join(folder_path, file)
        if os.path.isfile(file_path):
            os.remove(file_path)
            deleted_files.append(file)
            print(f"已删除文件：{file}")
        elif os.path.isdir(file_path):
            shutil.rmtree(file_path)
            deleted_files.append(file)
            print(f"已删除文件夹：{file}")
    if deleted_files:
        msg = f"已删除{len(deleted_files)}个以'.tar.gz'为后缀的文件：\n" + "\n".join(deleted_files)
        print(msg)
        send("文件删除通知", msg)
else:
    print("文件夹下没有以'.tar.gz'为后缀的文件")
