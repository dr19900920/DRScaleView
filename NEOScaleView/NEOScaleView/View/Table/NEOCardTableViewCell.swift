//
//  NEOCardTableViewCell.swift
//  ProjectDemo
//
//  Created by dengrui on 16/11/15.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit

class NEOCardTableViewCell: UITableViewCell {

    var cardView: NEOCardView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let cardView = NEOCardView.instanceView()
        self.addSubview(cardView)
        cardView.ff_Fill(self)
        self.cardView = cardView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
