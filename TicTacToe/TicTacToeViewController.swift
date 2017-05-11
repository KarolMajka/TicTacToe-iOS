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
    

    @IBOutlet var mainView: TicTacToeView!
    var ticTacToe = TicTacToeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setGestureRecognizers()
    }
    
    func setGestureRecognizers() {
        for subview in self.mainView.mainView.subviews {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapSingleField(_:)))
            subview.addGestureRecognizer(tap)
        }
    }
    
    func tapSingleField(_ sender: UITapGestureRecognizer) {
        for subview in self.mainView.mainView.subviews {
            let tapPoint = sender.location(in: subview)
            let subviewSize = subview.frame.size
            if tapPoint.x > 0 && tapPoint.x < subviewSize.width && tapPoint.y > 0 && tapPoint.y < subviewSize.height {
                self.tapped(view: subview)
                break
            }
        }
    }
    
    func tapped(view: UIView) {
        if !self.ticTacToe.setField(at: view.tag-100) {
            return
        }
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            let values = self.ticTacToe.checkWinner()
            guard let playerEnum = values.0,
                let combination = values.1 else {
                    self.noWinner()
                    return
            }
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.restartGame()
            })
            self.mainView.drawWinningLine(combination: combination)
            CATransaction.commit()
        })
        
        if self.ticTacToe.getCurrentMove() == PlayerEnum.crossPlayer {
            self.mainView.drawCircle(in: view)
        } else {
            self.mainView.drawCross(in: view)
        }
        CATransaction.commit()

    }
    
    func restartGame() {
        self.ticTacToe = TicTacToeModel()
        self.mainView.resetView()
    }
    
    func noWinner() {
        if !self.ticTacToe.isMoveAvailable() {
            self.restartGame()
        }
    }
}
