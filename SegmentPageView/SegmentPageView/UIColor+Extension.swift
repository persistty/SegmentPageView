//
//  UIColor+Extension.swift
//  SegmentPageView
//
//  Created by study on 16/5/2.
//  Copyright © 2016年 jimu. All rights reserved.
//

import UIKit

public extension UIColor {
    ///0x666666格式的颜色
    public convenience init(hexColor: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hexColor & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hexColor & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hexColor & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    ///rgb值
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}