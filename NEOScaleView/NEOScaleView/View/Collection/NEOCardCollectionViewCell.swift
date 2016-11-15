//
//  CardCollectionViewCell.swift
//  ProjectDemo
//
//  Created by dengrui on 16/11/15.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit

class NEOCardCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let cardView = NEOCardView.instanceView()
        self.addSubview(cardView)
        cardView.ff_Fill(self)
    }
    
}
