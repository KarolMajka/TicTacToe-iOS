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
    
    var mainView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createView()
    }
    
    private func createView() {
        self.addView()
        self.addLines()
    }
    
    private func addView() {
        let view = (Bundle.main.loadNibNamed("TicTacToeView", owner: self, options: nil)![0] as! UIView).subviews[0]
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        self.mainView = view
        
        let centerX = NSLayoutConstraint.init(item: view, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
        let centerY = NSLayoutConstraint.init(item: view, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
        let widthConstraint = NSLayoutConstraint.init(item: view, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0)
        let heightConstraint = NSLayoutConstraint.init(item: view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 0)
        self.addConstraints([centerX, centerY, widthConstraint, heightConstraint])
    }
    
    private func addLines() {
        self.addLine(from: CGPoint(x: self.mainView.frame.size.width/3, y: 0), to: CGPoint(x: self.mainView.frame.size.width/3, y: self.mainView.frame.size.height))
        self.addLine(from: CGPoint(x: self.mainView.frame.size.width/3*2, y: 0), to: CGPoint(x: self.mainView.frame.size.width/3*2, y: self.mainView.frame.size.height))
        
        self.addLine(from: CGPoint(x: 0, y: self.mainView.frame.size.height/3), to: CGPoint(x: self.mainView.frame.size.width, y: self.mainView.frame.size.height/3))
        self.addLine(from: CGPoint(x: 0, y: self.mainView.frame.size.height/3*2), to: CGPoint(x: self.mainView.frame.size.width, y: self.mainView.frame.size.height/3*2))
    }
    
    private func addLine(from: CGPoint, to: CGPoint) {
        let path = UIBezierPath()
        
        path.move(to: from)
        path.addLine(to: to)
        path.close()
        
        let layer = CAShapeLayer()
        
        layer.path = path.cgPath
        layer.lineWidth = 4
        layer.strokeColor = UIColor.blue.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        self.mainView.layer.addSublayer(layer)
    }
    
    
    
    func drawCircle(in view: UIView) {
        let size = self.mainView.subviews[0].frame.size
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: size.width/2,y: size.height/2), radius: CGFloat(size.height/3), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let layer = CAShapeLayer()
        layer.path = circlePath.cgPath
        layer.strokeColor = UIColor.blue.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 4
        //layer.strokeEnd = 0.0
        view.layer.addSublayer(layer)

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.3
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        layer.add(animation, forKey: "animate")
        
        
    }
    
    
    func drawCross(in view: UIView) {
        let size = self.mainView.subviews[0].frame.size
        let crossPath1 = UIBezierPath
        let layer = CAShapeLayer()
        layer.path = crossPath1.cgPath
        layer.strokeColor = UIColor.blue.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 4
        //layer.strokeEnd = 0.0
        //view.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 2.0
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        layer.add(animation, forKey: "animate")
    }
}
