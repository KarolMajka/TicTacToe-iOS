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
    let crossColor = UIColor(colorLiteralRed: 242/255, green: 233/255, blue: 211/255, alpha: 1.0)
    let circleColor = UIColor(colorLiteralRed: 84/255, green: 84/255, blue: 84/255, alpha: 1.0)
    let lineColor = UIColor(colorLiteralRed: 70/255, green: 162/255, blue: 146/255, alpha: 1.0)
    
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
        let layer = self.createLayer(forPath: path.cgPath, color: lineColor.cgColor)
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
        layer.lineWidth = 6
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
    
    func drawCircle(in viewID: Int, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        let view = self.mainView.viewWithTag(viewID+100)!
        let size = view.frame.size
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: size.width/2,y: size.height/2), radius: CGFloat(size.height/3), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let layer = self.createLayer(forPath: circlePath.cgPath, color: circleColor.cgColor)
        layer.name = "Circle"
        //layer.strokeEnd = 0.0
        view.layer.addSublayer(layer)
        self.addAnimation(forLayer: layer, duration: 0.2)
        CATransaction.commit()
    }
    
    
    func drawCross(in viewID: Int, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        let view = self.mainView.viewWithTag(viewID+100)!
        let size = view.frame.size
        
        let crossPath = CGMutablePath()
        let crossPath1 = self.createLinePath(from: CGPoint(x: size.width/4, y: size.height/4), to: CGPoint(x: size.width*3/4, y: size.height*3/4))
        let crossPath2 = self.createLinePath(from: CGPoint(x: size.width*3/4, y: size.height/4), to: CGPoint(x: size.width/4, y: size.height*3/4))
        
        crossPath.addPath(crossPath1.cgPath)
        crossPath.addPath(crossPath2.cgPath)
        
        let layer = self.createLayer(forPath: crossPath, color: crossColor.cgColor)
        layer.name = "Cross"
        view.layer.addSublayer(layer)
        self.addAnimation(forLayer: layer, duration: 0.2)
        CATransaction.commit()
    }
    
    func drawWinningLine(combination: [Int], winner: PlayerEnum, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        let firstView = self.mainView.viewWithTag(min(combination[0], combination[1], combination[2])+100)!
        let secondView = self.mainView.viewWithTag(max(combination[0], combination[1], combination[2])+100)!
        var firstPoint: CGPoint
        var secondPoint: CGPoint
        if compareEqual(combination[0], combination[1] - 1, combination[2] - 2) || compareEqual(combination[0], combination[1] + 1, combination[2] + 2) {
            firstPoint = CGPoint(x: firstView.frame.origin.x, y: firstView.frame.origin.y+firstView.frame.size.height/2)
            secondPoint = CGPoint(x: secondView.frame.origin.x+secondView.frame.size.width, y: secondView.frame.origin.y+secondView.frame.size.height/2)
            
        } else if compareEqual(combination[0], combination[1] + 3, combination[2] + 6) || compareEqual(combination[0], combination[1] - 3, combination[2] - 6) {
            firstPoint = CGPoint(x: firstView.frame.origin.x+firstView.frame.size.width/2, y: firstView.frame.origin.y)
            secondPoint = CGPoint(x: secondView.frame.origin.x+secondView.frame.size.width/2, y: secondView.frame.origin.y+secondView.frame.size.height)
            
        } else if firstView.tag == 100 {
            firstPoint = CGPoint(x: firstView.frame.origin.x, y: firstView.frame.origin.y)
            secondPoint = CGPoint(x: secondView.frame.origin.x+secondView.frame.size.width, y: secondView.frame.origin.y+secondView.frame.size.height)
            
        } else {
            firstPoint = CGPoint(x: firstView.frame.origin.x+firstView.frame.size.width, y: firstView.frame.origin.y)
            secondPoint = CGPoint(x: secondView.frame.origin.x, y: secondView.frame.origin.y+secondView.frame.size.height)
        }
        let path = self.createLinePath(from: firstPoint, to: secondPoint)
        
        var color: CGColor
        if PlayerEnum.circlePlayer == winner {
            color = circleColor.cgColor
        } else {
            color = crossColor.cgColor
        }
        
        let layer = self.createLayer(forPath: path.cgPath, color: color)
        layer.name = "WinningLine"
        self.mainView.layer.addSublayer(layer)
        self.addAnimation(forLayer: layer, duration: 0.3)
        CATransaction.commit()
    }
    
    private func compareEqual(_ val1: Int, _ val2: Int, _ val3: Int) -> Bool {
        if val1 == val2 && val1 == val3 {
            return true
        } else {
            return false
        }
    }
    
    func resetView() {
        for subview in self.mainView.subviews {
            subview.layer.sublayers?.removeAll()
        }
        self.mainView.layer.sublayers?.first(where: { layer in
            if layer.name != nil && layer.name! == "WinningLine" {
                return true
            } else {
                return false
            }
        })?.removeFromSuperlayer()
    }
    
}
