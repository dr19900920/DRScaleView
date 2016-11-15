//
//  UIView+Extension.swift
//  FFAutoLayout
//
//  Created by dengrui on 15/6/27.
//  Copyright © 2015年 joyios. All rights reserved.
//

import UIKit

///  对齐类型枚举，设置控件相对于父视图的位置
///
///  - TopLeft:      左上
///  - TopRight:     右上
///  - TopCenter:    中上
///  - BottomLeft:   左下
///  - BottomRight:  右下
///  - BottomCenter: 中下
///  - CenterLeft:   左中
///  - CenterRight:  右中
///  - CenterCenter: 中中
public enum ff_AlignType {
    case topLeft
    case topRight
    case topCenter
    case bottomLeft
    case bottomRight
    case bottomCenter
    case centerLeft
    case centerRight
    case centerCenter
    
    @discardableResult
    fileprivate func layoutAttributes(_ isInner: Bool, isVertical: Bool) -> ff_LayoutAttributes {
        let attributes = ff_LayoutAttributes()
        
        switch self {
        case .topLeft:
            attributes.horizontals(.left, to: .left).verticals(.top, to: .top)
            
            if isInner {
                return attributes
            } else if isVertical {
                return attributes.verticals(.bottom, to: .top)
            } else {
                return attributes.horizontals(.right, to: .left)
            }
        case .topRight:
            attributes.horizontals(.right, to: .right).verticals(.top, to: .top)
            
            if isInner {
                return attributes
            } else if isVertical {
                return attributes.verticals(.bottom, to: .top)
            } else {
                return attributes.horizontals(.left, to: .right)
            }
        case .topCenter:        // 仅内部 & 垂直参照需要
            attributes.horizontals(.centerX, to: .centerX).verticals(.top, to: .top)
            return isInner ? attributes : attributes.verticals(.bottom, to: .top)
        case .bottomLeft:
            attributes.horizontals(.left, to: .left).verticals(.bottom, to: .bottom)
            
            if isInner {
                return attributes
            } else if isVertical {
                return attributes.verticals(.top, to: .bottom)
            } else {
                return attributes.horizontals(.right, to: .left)
            }
        case .bottomRight:
            attributes.horizontals(.right, to: .right).verticals(.bottom, to: .bottom)
            
            if isInner {
                return attributes
            } else if isVertical {
                return attributes.verticals(.top, to: .bottom)
            } else {
                return attributes.horizontals(.left, to: .right)
            }
        case .bottomCenter:     // 仅内部 & 垂直参照需要
            attributes.horizontals(.centerX, to: .centerX).verticals(.bottom, to: .bottom)
            return isInner ? attributes : attributes.verticals(.top, to: .bottom)
        case .centerLeft:       // 仅内部 & 水平参照需要
            attributes.horizontals(.left, to: .left).verticals(.centerY, to: .centerY)
            return isInner ? attributes : attributes.horizontals(.right, to: .left)
        case .centerRight:      // 仅内部 & 水平参照需要
            attributes.horizontals(.right, to: .right).verticals(.centerY, to: .centerY)
            return isInner ? attributes : attributes.horizontals(.left, to: .right)
        case .centerCenter:     // 仅内部参照需要
            return ff_LayoutAttributes(horizontal: .centerX, referHorizontal: .centerX, vertical: .centerY, referVertical: .centerY)
        }
    }
}

extension UIView {
    
    ///  填充子视图
    ///
    ///  - parameter referView: 参考视图
    ///  - parameter insets:    间距
    @discardableResult
    public func ff_Fill(_ referView: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var cons = [NSLayoutConstraint]()
        
        cons += NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(insets.left)-[subView]-\(insets.right)-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: ["subView" : self])
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(insets.top)-[subView]-\(insets.bottom)-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: ["subView" : self])
        
        superview?.addConstraints(cons)
        
        return cons
    }
    
    ///  参照参考视图内部对齐
    ///
    ///  - parameter type:      对齐方式
    ///  - Parameter referView: 参考视图
    ///  - Parameter size:      视图大小，如果是 nil 则不设置大小
    ///  - Parameter offset:    偏移量，默认是 CGPoint(x: 0, y: 0)
    ///
    ///  - returns: 约束数组
    @discardableResult
    public func ff_AlignInner(type: ff_AlignType, referView: UIView, size: CGSize?, offset: CGPoint = CGPoint.zero) -> [NSLayoutConstraint]  {
        
        return ff_AlignLayout(referView, attributes: type.layoutAttributes(true, isVertical: true), size: size, offset: offset)
    }
    
    ///  参照参考视图垂直对齐
    ///
    ///  - parameter type:      对齐方式
    ///  - parameter referView: 参考视图
    ///  - parameter size:      视图大小，如果是 nil 则不设置大小
    ///  - parameter offset:    偏移量，默认是 CGPoint(x: 0, y: 0)
    ///
    ///  - returns: 约束数组
    @discardableResult
    public func ff_AlignVertical(type: ff_AlignType, referView: UIView, size: CGSize?, offset: CGPoint = CGPoint.zero) -> [NSLayoutConstraint] {
        
        return ff_AlignLayout(referView, attributes: type.layoutAttributes(false, isVertical: true), size: size, offset: offset)
    }
    
    ///  参照参考视图水平对齐
    ///
    ///  - parameter type:      对齐方式
    ///  - parameter referView: 参考视图
    ///  - parameter size:      视图大小，如果是 nil 则不设置大小
    ///  - parameter offset:    偏移量，默认是 CGPoint(x: 0, y: 0)
    ///
    ///  - returns: 约束数组
    @discardableResult
    public func ff_AlignHorizontal(type: ff_AlignType, referView: UIView, size: CGSize?, offset: CGPoint = CGPoint.zero) -> [NSLayoutConstraint] {
        
        return ff_AlignLayout(referView, attributes: type.layoutAttributes(false, isVertical: false), size: size, offset: offset)
    }
    
    ///  在当前视图内部水平平铺控件
    ///
    ///  - parameter views:  子视图数组
    ///  - parameter insets: 间距
    ///
    ///  - returns: 约束数组
    @discardableResult
    public func ff_HorizontalTile(_ views: [UIView], insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        
        assert(!views.isEmpty, "views should not be empty")
        
        var cons = [NSLayoutConstraint]()
        
        let firstView = views[0]
        firstView.ff_AlignInner(type: ff_AlignType.topLeft, referView: self, size: nil, offset: CGPoint(x: insets.left, y: insets.top))
        cons.append(NSLayoutConstraint(item: firstView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -insets.bottom))
        
        // 添加后续视图的约束
        var preView = firstView
        for i in 1..<views.count {
            let subView = views[i]
            cons += subView.ff_sizeConstraints(firstView)
            subView.ff_AlignHorizontal(type: ff_AlignType.topRight, referView: preView, size: nil, offset: CGPoint(x: insets.right, y: 0))
            preView = subView
        }

        let lastView = views.last!
        cons.append(NSLayoutConstraint(item: lastView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -insets.right))
        
        addConstraints(cons)
        return cons
    }
    
    ///  在当前视图内部垂直平铺控件
    ///
    ///  - parameter views:  子视图数组
    ///  - parameter insets: 间距
    ///
    ///  - returns: 约束数组
    @discardableResult
    public func ff_VerticalTile(_ views: [UIView], insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        
        assert(!views.isEmpty, "views should not be empty")
        
        var cons = [NSLayoutConstraint]()
        
        let firstView = views[0]
        firstView.ff_AlignInner(type: ff_AlignType.topLeft, referView: self, size: nil, offset: CGPoint(x: insets.left, y: insets.top))
        cons.append(NSLayoutConstraint(item: firstView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -insets.right))
        
        // 添加后续视图的约束
        var preView = firstView
        for i in 1..<views.count {
            let subView = views[i]
            cons += subView.ff_sizeConstraints(firstView)
            subView.ff_AlignVertical(type: ff_AlignType.bottomLeft, referView: preView, size: nil, offset: CGPoint(x: 0, y: insets.bottom))
            preView = subView
        }
        
        let lastView = views.last!
        cons.append(NSLayoutConstraint(item: lastView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -insets.bottom))
        
        addConstraints(cons)
        
        return cons
    }
    
    ///  从约束数组中查找指定 attribute 的约束
    ///
    ///  - parameter constraintsList: 约束数组
    ///  - parameter attribute:       约束属性
    ///
    ///  - returns: attribute 对应的约束
    @discardableResult
    public func ff_Constraint(_ constraintsList: [NSLayoutConstraint], attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        for constraint in constraintsList {
            if constraint.firstItem as! NSObject == self && constraint.firstAttribute == attribute {
                return constraint
            }
        }
        
        return nil
    }
    
    // MARK: - 私有函数
    ///  参照参考视图对齐布局
    ///
    ///  - parameter referView:  参考视图
    ///  - parameter attributes: 参照属性
    ///  - parameter size:       视图大小，如果是 nil 则不设置大小
    ///  - parameter offset:     偏移量，默认是 CGPoint(x: 0, y: 0)
    ///
    ///  - returns: 约束数组
    @discardableResult
    fileprivate func ff_AlignLayout(_ referView: UIView, attributes: ff_LayoutAttributes, size: CGSize?, offset: CGPoint) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var cons = [NSLayoutConstraint]()
        
        cons += ff_positionConstraints(referView, attributes: attributes, offset: offset)
        
        if size != nil {
            cons += ff_sizeConstraints(size!)
        }
        
        superview?.addConstraints(cons)
        
        return cons
    }
    
    ///  尺寸约束数组
    ///
    ///  - parameter size: 视图大小
    ///
    ///  - returns: 约束数组
    @discardableResult
    fileprivate func ff_sizeConstraints(_ size: CGSize) -> [NSLayoutConstraint] {
        
        var cons = [NSLayoutConstraint]()
        
        cons.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: size.width))
        cons.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: size.height))
        
        return cons
    }
    
    ///  尺寸约束数组
    ///
    ///  - parameter referView: 参考视图，与参考视图大小一致
    ///
    ///  - returns: 约束数组
    fileprivate func ff_sizeConstraints(_ referView: UIView) -> [NSLayoutConstraint] {

        var cons = [NSLayoutConstraint]()

        cons.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: referView, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0))
        cons.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: referView, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 0))

        return cons
    }
    
    ///  位置约束数组
    ///
    ///  - parameter referView:  参考视图
    ///  - parameter attributes: 参照属性
    ///  - parameter offset:     偏移量
    ///
    ///  - returns: 约束数组
    @discardableResult
    fileprivate func ff_positionConstraints(_ referView: UIView, attributes: ff_LayoutAttributes, offset: CGPoint) -> [NSLayoutConstraint] {
        
        var cons = [NSLayoutConstraint]()
        
        cons.append(NSLayoutConstraint(item: self, attribute: attributes.horizontal, relatedBy: NSLayoutRelation.equal, toItem: referView, attribute: attributes.referHorizontal, multiplier: 1.0, constant: offset.x))
        cons.append(NSLayoutConstraint(item: self, attribute: attributes.vertical, relatedBy: NSLayoutRelation.equal, toItem: referView, attribute: attributes.referVertical, multiplier: 1.0, constant: offset.y))
        
        return cons
    }
}

///  布局属性
private final class ff_LayoutAttributes {
    var horizontal:         NSLayoutAttribute
    var referHorizontal:    NSLayoutAttribute
    var vertical:           NSLayoutAttribute
    var referVertical:      NSLayoutAttribute
    
    init() {
        horizontal = NSLayoutAttribute.left
        referHorizontal = NSLayoutAttribute.left
        vertical = NSLayoutAttribute.top
        referVertical = NSLayoutAttribute.top
    }
    
    init(horizontal: NSLayoutAttribute, referHorizontal: NSLayoutAttribute, vertical: NSLayoutAttribute, referVertical: NSLayoutAttribute) {
        
        self.horizontal = horizontal
        self.referHorizontal = referHorizontal
        self.vertical = vertical
        self.referVertical = referVertical
    }
    
    @discardableResult
    fileprivate func horizontals(_ from: NSLayoutAttribute, to: NSLayoutAttribute) -> Self {
        horizontal = from
        referHorizontal = to
        
        return self
    }
    
    @discardableResult
    fileprivate func verticals(_ from: NSLayoutAttribute, to: NSLayoutAttribute) -> Self {
        vertical = from
        referVertical = to
        
        return self
    }
}
