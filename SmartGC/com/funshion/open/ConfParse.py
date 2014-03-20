#encoding=utf-8
'''
@author: guanzx
'''

from sys import argv
import os,ConfigParser
import json

def deligateBash(pathDir,pathDirOperate,fileDir,dateDir,fileDirOperate,fileLimit,fileFormat,fileOperate,limit):       
    if fileDir is not None:
        if dateDir is None:
            if fileDirOperate == "delete":
                cmd = "core-delete.sh "+" -f "+fileDir + " -o "+fileOperate + " -l " + limit + " -s" + fileFormat
                os.system(cmd)
        else:
            if fileOperate == "delete":
                cmd = "core-delete.sh "+" -f "+fileDir + " -o "+fileOperate +" -l "+ limit + " -d " + dateDir + " -s " + fileFormat
                os.system(cmd) 

def deligateFileBash(pathDir,pathDirOperate,fileDir,dateDir,fileDirOperate,fileLimit):
    if fileDirOperate is not None and fileDir is not None:
        if dateDir is None:
            if fileDirOperate == "delete":
                cmd = "core-delete.sh "+" -f "+fileDir + " -o "+fileDirOperate 
                os.system(cmd)
        else:
            if fileDirOperate == "delete":
                cmd = "core-delete.sh "+" -f "+fileDir + " -o "+fileDirOperate +" -l "+fileLimit + " -t " + dateDir

def deligatePathBash(pathDir,pathDirOperate):
    if pathDir is not None and pathDirOperate is not None:
        if pathDirOperate == "delete":
            cmd = "core-delete.sh "+" -p "+pathDir + " -o "+pathDirOperate 
            os.system(cmd)               

def getTypeCount(logType):
    return len(logType)

def parseLogTypeProperty(Logtype,proper):
    if Logtype.has_key(proper):
        typeValue = Logtype[proper]
    else:
        typeValue = ""
    return typeValue
               
def parseFileName(perPathType,pathDir,pathDirOperate,fileDir,dateDir,fileDirOperate,fileLimit):
    if perPathType.has_key("fileName"):
        fileName = perPathType["fileName"]
        fileNameCount = getTypeCount(fileName)
        if fileNameCount > 0 :
            for i in range(0,fileNameCount):
                fileFormat = parseLogTypeProperty(fileName[i],"format")
                fileOperate = parseLogTypeProperty(fileName[i],"operate")
                limit = parseLogTypeProperty(fileName[i],"limit")
                deligateBash(pathDir,pathDirOperate,fileDir,dateDir,fileDirOperate,fileLimit,fileFormat,fileOperate,limit)
        else:
            deligateFileBash(pathDir,pathDirOperate,fileDir,dateDir,fileDirOperate,fileLimit)
    else:
        deligateFileBash(pathDir,pathDirOperate,fileDir,dateDir,fileDirOperate,fileLimit)     

def parsePathName(perPathType,pathDir,pathDirOperate):
    if perPathType.has_key("pathName"):
        pathName = perPathType["pathName"]
        pathNameCount = getTypeCount(pathName)
        if pathNameCount > 0:
            for k in range(0,pathNameCount):
                fileDir = parseLogTypeProperty(pathName[k],"fileDir")
                dateDir = parseLogTypeProperty(pathName[k],"dateDir")
                fileDirOperate = parseLogTypeProperty(pathName[k],"operate")
                fileLimit = parseLogTypeProperty(pathName[k],"limit")      
                parseFileName(pathName[k],pathDir,pathDirOperate,fileDir,dateDir,fileDirOperate,fileLimit)
        else:
            deligateBash(pathDir,pathDirOperate)                           
    else:
        deligateBash(pathDir,pathDirOperate)

def parsePath(pathType):
    pathTypeCount = getTypeCount(pathType)
    if pathTypeCount > 0:
        for i in range(0,pathTypeCount):
            pathId =  parseLogTypeProperty(pathType[i],"pathId")
            pathDir =  parseLogTypeProperty(pathType[i],"pathDir")
            pathDirOperate =  parseLogTypeProperty(pathType[i],"operate")     
            parsePathName(pathType[i],pathDir,pathDirOperate)
                     
def parsePathType(typeId,proper): 
    if proper.has_key("pathType"):
        pathType = proper["pathType"]
        parsePath(pathType)
    else:
        print "请配置日志类型 %s 需要配置的文件信息 " %(typeId)

def parseLogType(logType):
    logTypeCount = getTypeCount(logType)
    for i in range(0,logTypeCount):  
        typeId = parseLogTypeProperty(logType[i],"typeId")
        parsePathType(typeId,logType[i])
            
def parseFile(conFile):
    jsonFile = json.load(confFile)
    logType = jsonFile["logType"]
    parseLogType(logType)
    

if __name__ == "__main__":   
   
    #baseDir = argv[1]
    #confFile = file(baseDir+"conf.json")
    confFile = file("E:/git/smart/SmartGC/etc/conf.json")
    parseFile(confFile)
    
        
