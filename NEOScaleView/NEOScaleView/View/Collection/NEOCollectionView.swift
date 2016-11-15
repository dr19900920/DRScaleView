//
//  NEOCollectionView.swift
//  ProjectDemo
//
//  Created by dengrui on 16/11/15.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit

class NEOCollectionView: UICollectionView {

    convenience init(frame: CGRect, itemSize: CGSize, lineSpacing: CGFloat = 0, margin: CGFloat = 0, scale: CGFloat = 0.1) {
        let layout = NEOCardCollectionLayout()
        layout.scale = scale
        layout.itemSize = itemSize
        layout.minimumLineSpacing = lineSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.init(frame: frame, collectionViewLayout: layout)
//        self.bounces = false
        self.showsHorizontalScrollIndicator = false
    }

}
