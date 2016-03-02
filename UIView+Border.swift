//
//  UIView+Border.swift
//
//  Created by oney on 3/2/16.
//  Copyright © 2016 oney. All rights reserved.
//

import UIKit
import ObjectiveC

class Border {
    enum Position: Int {
        case Top = 1130001
        case Bottom = 1130002
        case Left = 1130003
        case Right = 1130004
    }

    let size: CGFloat
    let color: UIColor
    let offset: UIEdgeInsets
    init(size: CGFloat, color: UIColor, offset: UIEdgeInsets) {
        self.size = size
        self.color = color
        self.offset = offset
    }

    func horizontal(position: Position) -> String {
        switch position {
        case .Top, .Bottom:
            return "H:|-(\(offset.left))-[v]-(\(offset.right))-|"
        case .Left:
            return "H:|-(\(offset.left))-[v(\(size))]"
        case .Right:
            return "H:[v(\(size))]-(\(offset.right))-|"
        }
    }
    func vertical(position: Position) -> String {
        switch position {
        case .Top:
            return "V:|-(\(offset.top))-[v(\(size))]"
        case .Bottom:
            return "V:[v(\(size))]-(\(offset.bottom))-|"
        case .Left, .Right:
            return "V:|-(\(offset.top))-[v]-(\(offset.bottom))-|"
        }
    }
}

private var borderTopAssociationKey: UInt8 = 0
private var borderBottomAssociationKey: UInt8 = 0
private var borderLeftAssociationKey: UInt8 = 0
private var borderRightAssociationKey: UInt8 = 0

extension UIView {
    var borderTop: Border? {
        set {
            objc_setAssociatedObject(self, &borderTopAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setBorderUtility(newValue, position: .Top)
        }
        get {
            return objc_getAssociatedObject(self, &borderTopAssociationKey) as? Border
        }
    }
    var borderBottom: Border? {
        set {
            objc_setAssociatedObject(self, &borderBottomAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setBorderUtility(newValue, position: .Bottom)
        }
        get {
            return objc_getAssociatedObject(self, &borderBottomAssociationKey) as? Border
        }
    }
    var borderLeft: Border? {
        set {
            objc_setAssociatedObject(self, &borderLeftAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setBorderUtility(newValue, position: .Left)
        }
        get {
            return objc_getAssociatedObject(self, &borderLeftAssociationKey) as? Border
        }
    }
    var borderRight: Border? {
        set {
            objc_setAssociatedObject(self, &borderRightAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setBorderUtility(newValue, position: .Right)
        }
        get {
            return objc_getAssociatedObject(self, &borderRightAssociationKey) as? Border
        }
    }
    func setBorderUtility(newValue: Border?, position: Border.Position) {
        let BorderTag = position.rawValue

        let v = self.viewWithTag(BorderTag)
        if let border = newValue {
            if v != nil {
                v?.removeFromSuperview()
            }
            let v = UIView()
            v.tag = BorderTag
            v.backgroundColor = border.color
            addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(border.horizontal(position), options: .DirectionLeadingToTrailing, metrics: nil, views: ["v": v]))
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(border.vertical(position), options: .DirectionLeadingToTrailing, metrics: nil, views: ["v": v]))
        } else {
            if v != nil {
                v?.removeFromSuperview()
            }
        }
    }
}
