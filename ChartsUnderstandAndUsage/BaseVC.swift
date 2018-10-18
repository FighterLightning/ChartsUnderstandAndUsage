//
//  BaseVC.swift
//  ChartsUnderstandAndUsage
//
//  Created by 张海峰 on 2018/10/18.
//  Copyright © 2018年 张海峰. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    var refreshrBtn: UIButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ZHFColor.white
        //添加刷新按钮
        refreshrBtn = UIButton.init(type: UIButtonType.custom)
        refreshrBtn.frame = CGRect.init(x: 30, y: 84, width: 40, height: 25)
        refreshrBtn.setTitle("刷新", for: UIControlState.normal)
        refreshrBtn.backgroundColor = ZHFColor.red
        refreshrBtn.setTitleColor(ZHFColor.zhf33_titleTextColor, for: UIControlState.normal)
        refreshrBtn.layer.cornerRadius = 5
        refreshrBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(refreshrBtn)
    }
}
