#encoding=utf-8
'''
Created on 2014��3��13��

@author: guanzx
'''

from sys import argv
import os
import json

confFile = file("D:/SmartGC/conf.json")
jsonFile = json.load(confFile)

logType = jsonFile["logType"]

logTypeCount = len(logType)

    

for i in range(0,logTypeCount):
    
    # 对于每一个key增加一个判断其是否存在的方法    
    if logType[i].has_key("type"):
        typeValue = logType[i]["type"]
        if logType[i].has_key("baseDir"):
            baseDir = logType[i]["baseDir"]
            if logType[i].has_key("pathType"):
                pathType = logType[i]["pathType"]
                
                pathTypeCount = len(pathType)
                
                for j in range(0,pathTypeCount):
                    path = pathType[j]["path"]
                    pathDir = pathType[j]["pathDir"]
                    deleteWholeDir = pathType[j]["deleteWholeDir"]
                    fileType = pathType[j]["file"]
                    fileTypeCount = len(fileType)
                    if fileTypeCount > 0:
                        for k in range(0,fileTypeCount):
                            format = fileType[k]["format"]
                            operation = fileType[k]["operation"]
                            limit = fileType[k]["limit"]
                            #到此，所有的变量已经遍历出来，去调用shell脚本进行处理
                            cmd = "core-control.sh "+"-b "+baseDir+" -p "+pathDir+" -f "+format+" -o " +operation+" -l " + limit +" -d "+deleteWholeDir
                            os.system(cmd)
        
