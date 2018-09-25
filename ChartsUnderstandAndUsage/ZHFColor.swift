//
//  ZHFColor.swift
//  AmazedBox
//
//  Created by lantian on 2018/5/9.
//  Copyright © 2018年 张海峰. All rights reserved.
//
/*该demo是和大家分享一下，在项目中自定义各种弹框的思路，用来支撑自己项目的使用，无论什么样的弹框，只要有思路，
相信大家都能完美实现。感觉我这个demo对你有启发或者帮助，不妨给个星星吧
    https://github.com/FighterLightning/ZHFToolBox.git
 */
import UIKit

class ZHFColor: UIColor {
    /// 主题色（及选中颜色）
    open class var zhf_selectColor: UIColor {
        //橙色
        get {
            return self.zhf_color(withHex: 0xF98507)
        }
    }
    /// 标题字体颜色
    open class var zhf33_titleTextColor: UIColor {
        get {
            return self.zhf_color(withHex: 0x333333)
        }
    }
    /// 内容字体颜色1
    open class var zhf88_contentTextColor: UIColor {
        get {
            return self.zhf_color(withHex: 0x888888)
        }
    }
    /// 内容字体颜色2
    open class var zhf66_contentTextColor: UIColor {
        get {
            return self.zhf_color(withHex: 0x666666)
        }
    }
    /// 背景色1
    open class var zhfe8_backGroundColor: UIColor {
        get {
            return self.zhf_color(withHex: 0xe8e8e8)
        }
    }
    /// 背景色2
    open class var zhff9_backGroundColor: UIColor {
        get {
            return self.zhf_color(withHex: 0xf9f9f9)
        }
    }
    /// 分割线的颜色1
    open class var zhfcc_lineColor: UIColor {
        get {
            return self.zhf_color(withHex: 0xcccccc)
        }
    }
    /// 分割线的颜色2
    open class var zhf_lineColor: UIColor {
        get {
            return self.zhf_color(withHex: 0xebf0f5)
        }
    }
    /// 随机的颜色
    class func zhf_randomColor() -> UIColor {
        let r = CGFloat(arc4random() % 256) / 255.0
        let g = CGFloat(arc4random() % 256) / 255.0
        let b = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    /// 十六进制颜色 0xFFFFFF （0x六位颜色）
    class func zhf_color(withHex: UInt32) -> UIColor {
        let r = ((CGFloat)((withHex & 0xFF0000) >> 16)) / 255.0
        let g = ((CGFloat)((withHex & 0xFF00) >> 8)) / 255.0
        let b = ((CGFloat)(withHex & 0xFF)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    /// 十六进制颜色（带透明度） 0xFFFFFF （0x六位颜色）
    class func zhf_colorAlpha(withHex: UInt32,alpha: CGFloat) -> UIColor {
        let r = ((CGFloat)((withHex & 0xFF0000) >> 16)) / 255.0
        let g = ((CGFloat)((withHex & 0xFF00) >> 8)) / 255.0
        let b = ((CGFloat)(withHex & 0xFF)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    ///  0~255 颜色
    ///  red(0~255)
    ///  green(0~255)
    ///  blue(0~255)
    class func zhf_color(withRed: UInt8, green: UInt8, blue: UInt8) -> UIColor {
        let r = CGFloat(withRed) / 255.0
        let g = CGFloat(green) / 255.0
        let b = CGFloat(blue) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    /// 字符串颜色 "六位颜色"
    class func zhf_strColor(hex: String) -> UIColor {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0
        let g = ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0
        let b = ((CGFloat)(rgbValue & 0xFF)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

