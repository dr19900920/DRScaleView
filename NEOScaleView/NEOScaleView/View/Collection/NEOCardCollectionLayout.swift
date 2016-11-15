//
//  GrabCollectionLayout.swift
//  yingmen
//
//  Created by venusource on 16/9/26.
//  Copyright © 2016年 venusource. All rights reserved.
//

import UIKit

class NEOCardCollectionLayout: UICollectionViewFlowLayout {
    
    var scale: CGFloat = 0.1
    
    //滑动时缩放cell
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let items = makeLayoutAttributeItems()
        if items.count > 0 {
            for value in items {
                //获得item距离左边的边框的距离
                let leftdelta = value.center.x - collectionView!.contentOffset.x
                //获得屏幕的中心点
                let centerX = collectionView!.frame.size.width * 0.5
                //获得距离中心的距离
                let dela = fabs(centerX - leftdelta)
                //左边的item缩小
                let rightscale = 1.00-dela/centerX
                //缩放
                value.transform = CGAffineTransform(scaleX: 1+rightscale*scale, y: 1+rightscale*scale);
            }
            return items
            
        }
        return nil
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        super.shouldInvalidateLayout(forBoundsChange: newBounds)
        return true
    }
    
    //让cell停在中间位置
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        var contentOffset = proposedContentOffset
        
        let items = makeLayoutAttributeItems()
        if items.count > 0 {
            var mindelta = CGFloat.greatestFiniteMagnitude
            for item in items {
                //获得item距离左边的边框的距离
                let leftdelta = item.center.x - contentOffset.x
                //获得屏幕的中心点
                let centerX = collectionView!.frame.size.width * 0.5
                //获得距离中心的距离
                let dela = fabs(centerX - leftdelta)
                //获得最小的距离
                if (dela <= mindelta){
                    mindelta = centerX - leftdelta
                }
            }
            contentOffset.x -= mindelta
            
            //防止在第一个和最后一个 滑到中间时 卡住
            if (contentOffset.x < 0) {
                contentOffset.x = 0
            }
            
            if (contentOffset.x > (collectionView!.contentSize.width-sectionInset.left-sectionInset.right-itemSize.width*1.5)) {
                contentOffset.x = floor(contentOffset.x);
            }
            
        }
        return contentOffset
    }
    
    private func makeLayoutAttributeItems() -> [UICollectionViewLayoutAttributes] {
        //确定加载item的区域
        let x =  collectionView!.contentOffset.x
        let w = collectionView!.frame.size.width
        let h = collectionView!.frame.size.height
        let myrect = CGRect(x: x, y: 0, width: w, height: h)
        guard let arr = super.layoutAttributesForElements(in: myrect) else {
            fatalError()
        }
        let hehe = arr.map{$0.copy() as! UICollectionViewLayoutAttributes}
        //获得这个区域的item
        return hehe
    }
    
}


