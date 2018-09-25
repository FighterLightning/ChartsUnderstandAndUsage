//
//  AppDelegate.swift
//  ChartsUnderstandAndUsage
//
//  Created by 张海峰 on 2018/9/12.
//  Copyright © 2018年 张海峰. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}
//定义一个全局函数打印方法
//自定义标记 ->项目 ->buildSettings -> swift flag ->Debug ->  -D DEBUG
func ZHFLog<T>(message : T, file : String = #file, line : Int = #line) {
    //在DEBUG环境下打印，在RELEASE环境下不打印
    #if DEBUG
    let file1 = (file as NSString).lastPathComponent
    let line1 = (line as Int)
    print("\(file1):line\(line1)---\(message)")
    #endif
}


