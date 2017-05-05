//
//  TicTacToeViewController.swift
//  TicTacToe
//
//  Created by Karol Majka on 05/05/2017.
//  Copyright © 2017 karolmajka. All rights reserved.
//

import Foundation
import UIKit

class TicTacToeViewController: UIViewController {
    
    lazy var mainView: TicTacToeView = {
        [unowned self] in
        return self.view.viewWithTag(100) as! TicTacToeView
    }()
    var ticTacToe = TicTacToeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setGestureRecognizers()
    }
    
    func setGestureRecognizers() {
        for subview in self.mainView.subviews {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapSingleField(_:)))
            subview.addGestureRecognizer(tap)
        }
    }
    
    func tapSingleField(_ sender: UITapGestureRecognizer) {
        for subview in self.mainView.subviews {
            let tapPoint = sender.location(in: subview)
            let subviewSize = subview.frame.size
            if tapPoint.x > 0 && tapPoint.x < subviewSize.width && tapPoint.y > 0 && tapPoint.y < subviewSize.height {
                self.tapped(view: subview)
                break
            }
        }
    }
    
    func tapped(view: UIView) {
        if self.ticTacToe.currentMove == PlayerEnum.circlePlayer {
            self.mainView.drawCircle(in: view)
        } else {
            self.mainView.drawCross(in: view)
        }
        self.ticTacToe.toggleCurrentMove()
    }
}
