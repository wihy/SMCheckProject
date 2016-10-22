//
//  ParsingMethod.swift
//  SMCheckProject
//
//  Created by didi on 2016/10/20.
//  Copyright © 2016年 Starming. All rights reserved.
//

import Cocoa

class ParsingMethod: ParsingBase {
    func parsingWithArray(arr:Array<String>) -> Method {
        let mtd = Method()
        var returnTypeTf = false //是否取得返回类型
        var parsingTf = false //解析中
        var bracketCount = 0 //括弧计数
        var step = 0 //1获取参数名，2获取参数类型，3获取iName
        var types = [String]()
        var methodParam = MethodParam()
        print("\(arr)")
        for tk in arr {
            if (tk == ";" || tk == "{") && step != 1 {
                mtd.params.append(methodParam)
            } else if tk == "(" {
                bracketCount += 1
                parsingTf = true
            } else if tk == ")" {
                bracketCount -= 1
                if bracketCount == 0 {
                    var typeString = ""
                    for typeTk in types {
                        typeString = typeString.appending(typeTk)
                    }
                    if !returnTypeTf {
                        //完成获取返回
                        mtd.returnType = typeString
                        step = 1
                        returnTypeTf = true
                    } else {
                        if step == 2 {
                            methodParam.type = typeString
                            step = 3
                        }
                        
                    }
                    //括弧结束后的重置工作
                    parsingTf = false
                    types = []
                }
            } else if parsingTf {
                types.append(tk)
            } else if tk == ":" {
                step = 2
            } else if step == 1 {
                methodParam.name = tk
                step = 0
            } else if step == 3 {
                methodParam.iName = tk
                step = 1
                mtd.params.append(methodParam)
                methodParam = MethodParam()
            } else if tk != "-" && tk != "+" {
                methodParam.name = tk
            }
            
        }//遍历
        
//        print(mtd.params)
        
        return mtd
    }
}
