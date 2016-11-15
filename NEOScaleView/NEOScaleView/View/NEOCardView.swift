//
//  CardView.swift
//  ProjectDemo
//
//  Created by dengrui on 16/11/15.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit

class NEOCardView: UIView {
    
    class func instanceView() -> NEOCardView {
        return Bundle.main.loadNibNamed("NEOCardView", owner: nil, options: nil)?.first as! NEOCardView
    }
    
}
