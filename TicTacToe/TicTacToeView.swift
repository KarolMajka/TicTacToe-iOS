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
        let path = self.createLinePath(from: from, to: to)
        let layer = self.createLayer(forPath: path.cgPath, color: UIColor.blue.cgColor)
        self.mainView.layer.addSublayer(layer)
    }
    
    private func createLinePath(from: CGPoint, to: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: from)
        path.addLine(to: to)
        path.close()
        return path
    }
    
    private func createLayer(forPath path: CGPath, color: CGColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        
        layer.path = path
        layer.lineWidth = 4
        layer.strokeColor = color
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }
    
    private func addAnimation(forLayer layer: CAShapeLayer, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        layer.add(animation, forKey: "animate")
    }
    
    func drawCircle(in view: UIView) {
        let size = view.frame.size
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: size.width/2,y: size.height/2), radius: CGFloat(size.height/3), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let layer = self.createLayer(forPath: circlePath.cgPath, color: UIColor.blue.cgColor)
        //layer.strokeEnd = 0.0
        view.layer.addSublayer(layer)
        self.addAnimation(forLayer: layer, duration: 0.3)
    }
    
    
    func drawCross(in view: UIView) {
        let size = view.frame.size
        let crossPath = CGMutablePath()
        let crossPath1 = self.createLinePath(from: CGPoint(x: size.width/4, y: size.height/4), to: CGPoint(x: size.width*3/4, y: size.height*3/4))
        let crossPath2 = self.createLinePath(from: CGPoint(x: size.width*3/4, y: size.height/4), to: CGPoint(x: size.width/4, y: size.height*3/4))
        
        crossPath.addPath(crossPath1.cgPath)
        crossPath.addPath(crossPath2.cgPath)
        
        let layer = self.createLayer(forPath: crossPath, color: UIColor.blue.cgColor)
        view.layer.addSublayer(layer)
        self.addAnimation(forLayer: layer, duration: 0.3)
    }
    
    func resetView() {
        for subview in self.mainView.subviews {
            subview.layer.sublayers?.removeAll()
        }
    }
    
}
