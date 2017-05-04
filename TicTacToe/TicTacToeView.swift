//
//  TicTacToeView.swift
//  TicTacToe
//
//  Created by Karol Majka on 04/05/2017.
//  Copyright © 2017 karolmajka. All rights reserved.
//

import Foundation
import UIKit

class TicTacToeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createSubviews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let size = min(self.frame.size.width, self.frame.size.height)/3
        for i in 0...8 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            view.translatesAutoresizingMaskIntoConstraints = false
            view.tag = 100+i
            view.backgroundColor = UIColor.clear
            
            //Height and Width Constraint
            if i == 0 {
                let widthConstraint = NSLayoutConstraint.init(item: view, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: size)
                let heightConstraint = NSLayoutConstraint.init(item: view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: size)
                view.addConstraints([widthConstraint, heightConstraint])
            } else {
                let view2 = self.viewWithTag(100)!
                let widthConstraint = NSLayoutConstraint.init(item: view, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view2, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0)
                let heightConstraint = NSLayoutConstraint.init(item: view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: view2, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 0)
                view.addConstraints([widthConstraint, heightConstraint])
            }
            
            //Top Constraint
            if i < 3 {
                let constraint = NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
                self.addConstraint(constraint)
            } else {
                let view2 = self.viewWithTag(100+i-3)!
                let constraint = NSLayoutConstraint.init(item: view2, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
                view.addConstraint(constraint)
            }
            
            //Leading Constraint
            if i % 3 == 0 {
                let constraint = NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
                self.addConstraint(constraint)
            } else {
                let view2 = self.viewWithTag(100+i-3)!
                let constraint = NSLayoutConstraint.init(item: view2, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
                view.addConstraint(constraint)
            }
            
            //Trailing Constraint
            if i % 3 == 2 {
                let constraint = NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
                self.addConstraint(constraint)
            }
            
            //Bottom Constraint
            if i > 5 {
                let constraint = NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
                self.addConstraint(constraint)
            }
            
            self.addSubview(view)
        }
        
    }
    
}
