//
//  ExpandButtonView.swift
//  TicTacToe
//
//  Created by Karol Majka on 01/06/2017.
//  Copyright © 2017 karolmajka. All rights reserved.
//

import UIKit

class ExpandButtonView: UIView {
    
    lazy var subview: UIButton = {
        [unowned self] in
        let subview = self.subviews[safe: 0] as! UIButton
        return subview
        }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.subview.isHighlighted = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.subview.isHighlighted {
            self.subview.isHighlighted = false
            guard let action = self.subview.actions(forTarget: subview.allTargets.first, forControlEvent: self.subview.allControlEvents)?.first else {
                return
            }
            let selector = NSSelectorFromString(action)
            self.subview.sendAction(selector, to: nil, for: nil)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        if location.x < 0 || location.y < 0 || location.x > self.frame.width || location.y > self.frame.height {
            self.subview.isHighlighted = false
        } else {
            self.subview.isHighlighted = true
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.subview.isHighlighted = false
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view:UIView? = super.hitTest(point, with: event)
        if view != nil {
            return self
        }
        return nil
    }
}

extension Array {
    public subscript (safe index: Index) -> Element? {
        return index.distance(to: endIndex) > 0 ? self[index] : nil
    }
}
