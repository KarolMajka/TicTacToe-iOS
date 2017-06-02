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
    
    //MARK: - variables
    @IBOutlet private var mainView: TicTacToeView!
    private var ticTacToe = TicTacToeModel()
    
    var bot = false
    let botManagement = TicTacToeBot(side: PlayerEnum.crossPlayer)
    
    
    //MARK: - UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setGestureRecognizers()
        self.mainView.isUserInteractionEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.isBeingPresented || self.isMovingToParentViewController {
            if self.bot && self.ticTacToe.getCurrentMove() == PlayerEnum.crossPlayer {
                self.botMove()
            } else {
                self.mainView.isUserInteractionEnabled = true
            }
        }
    }
    
    private func setGestureRecognizers() {
        for subview in self.mainView.mainView.subviews {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapSingleField(_:)))
            subview.addGestureRecognizer(tap)
        }
    }
    
    
    //MARK: - IBAction methods
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
    
    @IBAction private func tapBackButton() {
        self.navigationController!.popViewController(animated: true)
    }
    
    
    //MARK: - TicTacToe methods
    private func move(_ viewId: Int) {
        self.drawNextMove(viewId: viewId, completion: {
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
            self.drawWinningLine(combination: combination, completion: {
                self.restartGame()
                self.mainView.isUserInteractionEnabled = true
            })
        })
    }

    private func drawNextMove(viewId: Int, completion: @escaping ()->()) {
        if self.ticTacToe.getCurrentMove() == PlayerEnum.crossPlayer {
            self.mainView.drawCircle(in: viewId, completion: completion)
        } else {
            self.mainView.drawCross(in: viewId, completion: completion)
        }
    }
    
    private func drawWinningLine(combination: [Int], completion: @escaping () ->()) {
        if self.ticTacToe.getCurrentMove() == PlayerEnum.circlePlayer {
            self.mainView.drawWinningLine(combination: combination, winner: PlayerEnum.crossPlayer, completion: completion)
        } else {
            self.mainView.drawWinningLine(combination: combination, winner: PlayerEnum.circlePlayer, completion: completion)
        }
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
    
    private func botMove() {
        let viewId = botManagement.getMove(model: self.ticTacToe)
        let _ = self.ticTacToe.setField(at: viewId)
        self.drawNextMove(viewId: viewId, completion: {
            let values = self.ticTacToe.checkWinner()
            guard let playerEnum = values.0,
                let combination = values.1 else {
                    let _ = self.noWinner()
                    self.mainView.isUserInteractionEnabled = true
                    return
            }
            self.drawWinningLine(combination: combination, completion: {
                self.restartGame()
                self.mainView.isUserInteractionEnabled = true
            })
        })
    }
    
    
}
