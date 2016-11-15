//
//  StyleTool.swift
//  ProjectDemo
//
//  Created by dengrui on 16/11/2.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit

//屏幕适配
public let kScreenWidth = UIScreen.main.bounds.width
public let kScreenHeight = UIScreen.main.bounds.height
public let kNavBarH: CGFloat = 64.0
public let kTabBarH: CGFloat = 49.0
public let kSCREEN_WIDTH_RATIO: CGFloat =  kScreenWidth >= 375 ? kScreenWidth/375.0 : 1
public let kSCREEN_HEIGHT_RATIO: CGFloat = kScreenHeight >= 667 ? kScreenHeight/667.0 : 1

public func kAutoWEX(w: CGFloat) -> CGFloat {
    return w * kSCREEN_WIDTH_RATIO
}

public func kAutoHEX(h: CGFloat) -> CGFloat {
    return h * kSCREEN_HEIGHT_RATIO
}

