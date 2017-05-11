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

    @IBOutlet private var mainView: TicTacToeView!
    private var ticTacToe = TicTacToeModel()
    
    var bot = false
    let botManagement = TicTacToeBot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setGestureRecognizers()
        if self.bot && self.ticTacToe.getCurrentMove() == PlayerEnum.crossPlayer {
            self.botMove()
        }
    }
    
    private func setGestureRecognizers() {
        for subview in self.mainView.mainView.subviews {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapSingleField(_:)))
            subview.addGestureRecognizer(tap)
        }
    }
    
    @objc private func tapSingleField(_ sender: UITapGestureRecognizer) {
        self.mainView.isUserInteractionEnabled = false
        for subview in self.mainView.mainView.subviews {
            let tapPoint = sender.location(in: subview)
            let subviewSize = subview.frame.size
            if tapPoint.x > 0 && tapPoint.x < subviewSize.width && tapPoint.y > 0 && tapPoint.y < subviewSize.height {
                self.tapped(view: subview)
                break
            }
        }
    }
    
    private func tapped(view: UIView) {
        if !self.ticTacToe.setField(at: view.tag-100) {
            return
        } else {
            self.move(view.tag-100)
        }
    }
    
    private func move(_ viewID: Int) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            let values = self.ticTacToe.checkWinner()
            guard let playerEnum = values.0,
                let combination = values.1 else {
                    if !self.noWinner() && self.bot {
                        self.botMove()
                    } else {
                        self.mainView.isUserInteractionEnabled = true
                    }
                    return
            }
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.restartGame()
                self.mainView.isUserInteractionEnabled = true
            })
            self.mainView.drawWinningLine(combination: combination)
            CATransaction.commit()
        })
        
        if self.ticTacToe.getCurrentMove() == PlayerEnum.crossPlayer {
            self.mainView.drawCircle(in: viewID)
        } else {
            self.mainView.drawCross(in: viewID)
        }
        CATransaction.commit()

    }
    
    private func botMove() {
        let viewID = botManagement.move(field: ticTacToe)
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            let values = self.ticTacToe.checkWinner()
            guard let playerEnum = values.0,
                let combination = values.1 else {
                    let _ = self.noWinner()
                    self.mainView.isUserInteractionEnabled = true
                    return
            }
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.restartGame()
                self.mainView.isUserInteractionEnabled = true
            })
            self.mainView.drawWinningLine(combination: combination)
            CATransaction.commit()
        })
        
        if self.ticTacToe.getCurrentMove() == PlayerEnum.crossPlayer {
            self.mainView.drawCircle(in: viewID)
        } else {
            self.mainView.drawCross(in: viewID)
        }
        CATransaction.commit()
    }
    
    private func restartGame() {
        self.ticTacToe = TicTacToeModel()
        self.mainView.resetView()
        if self.bot && self.ticTacToe.getCurrentMove() == PlayerEnum.crossPlayer {
            self.botMove()
        }
    }
    
    private func noWinner() -> Bool {
        if !self.ticTacToe.isMoveAvailable() {
            self.restartGame()
            
            return true
        }
        return false
    }
}
