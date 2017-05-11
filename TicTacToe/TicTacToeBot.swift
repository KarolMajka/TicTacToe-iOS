//
//  TicTacToeBot.swift
//  TicTacToe
//
//  Created by Karol Majka on 11/05/2017.
//  Copyright © 2017 karolmajka. All rights reserved.
//

import Foundation

class TicTacToeBot {
    var botSide: PlayerEnum
    
    init(side: PlayerEnum) {
        self.botSide = side
    }
    
    func getMove(model: TicTacToeModel) -> Int {
        var move = -1
        
        move = self.canWin(player: botSide, model: model)
        if move != -1 {
            return move
        }
        
        var opponentSide: PlayerEnum
        if botSide == PlayerEnum.circlePlayer {
            opponentSide = PlayerEnum.crossPlayer
        } else {
            opponentSide = PlayerEnum.circlePlayer
        }
        move = self.canWin(player: opponentSide, model: model)
        if move != -1 {
            return move
        }
        
        let movesCount = self.getMovesCount(model: model)
        return self.findMove(movesCount: movesCount, model: model)
    }
    
    private func getMovesCount(model: TicTacToeModel) -> Int {
        var count = 0
        for i in 0...8 {
            if model.getField(at: i) != FieldEnum.empty {
                count += 1
            }
        }
        return count
    }
    
    private func canWin(player: PlayerEnum, model: TicTacToeModel) -> Int {
        var field: FieldEnum
        if player == PlayerEnum.circlePlayer {
            field = FieldEnum.circle
        } else {
            field = FieldEnum.cross
        }
        
        if model.getField(at: 0) == FieldEnum.empty && (
            (model.getField(at: 1) == model.getField(at: 2) && model.getField(at: 1) == field) ||
                (model.getField(at: 3) == model.getField(at: 6) && model.getField(at: 3) == field) ||
                (model.getField(at: 4) == model.getField(at: 8) && model.getField(at: 4) == field)
            ) {
            return 0
        }
        
        if model.getField(at: 1) == FieldEnum.empty && (
            (model.getField(at: 0) == model.getField(at: 2) && model.getField(at: 0) == field) ||
                (model.getField(at: 4) == model.getField(at: 7) && model.getField(at: 4) == field)
            ) {
            return 1
        }
        
        if model.getField(at: 2) == FieldEnum.empty && (
            (model.getField(at: 0) == model.getField(at: 1) && model.getField(at: 0) == field) ||
                (model.getField(at: 5) == model.getField(at: 8) && model.getField(at: 5) == field) ||
                (model.getField(at: 4) == model.getField(at: 6) && model.getField(at: 4) == field)
            ) {
            return 2
        }
        
        if model.getField(at: 3) == FieldEnum.empty && (
            (model.getField(at: 0) == model.getField(at: 6) && model.getField(at: 0) == field) ||
                (model.getField(at: 4) == model.getField(at: 5) && model.getField(at: 4) == field)
            ) {
            return 3
        }
        
        if model.getField(at: 4) == FieldEnum.empty && (
            (model.getField(at: 3) == model.getField(at: 5) && model.getField(at: 3) == field) ||
                (model.getField(at: 1) == model.getField(at: 7) && model.getField(at: 1) == field) ||
                (model.getField(at: 0) == model.getField(at: 8) && model.getField(at: 0) == field)
            ) {
            return 4
        }
        
        if model.getField(at: 5) == FieldEnum.empty && (
            (model.getField(at: 3) == model.getField(at: 4) && model.getField(at: 3) == field) ||
                (model.getField(at: 2) == model.getField(at: 8) && model.getField(at: 2) == field)
            ) {
            return 5
        }
        
        if model.getField(at: 6) == FieldEnum.empty && (
            (model.getField(at: 7) == model.getField(at: 8) && model.getField(at: 7) == field) ||
                (model.getField(at: 0) == model.getField(at: 3) && model.getField(at: 0) == field) ||
                (model.getField(at: 4) == model.getField(at: 2) && model.getField(at: 4) == field)
            ) {
            return 6
        }
        
        if model.getField(at: 7) == FieldEnum.empty && (
            (model.getField(at: 6) == model.getField(at: 8) && model.getField(at: 6) == field) ||
                (model.getField(at: 1) == model.getField(at: 4) && model.getField(at: 1) == field)
            ) {
            return 7
        }
        
        if model.getField(at: 8) == FieldEnum.empty && (
            (model.getField(at: 6) == model.getField(at: 7) && model.getField(at: 6) == field) ||
                (model.getField(at: 2) == model.getField(at: 5) && model.getField(at: 2) == field) ||
                (model.getField(at: 0) == model.getField(at: 4) && model.getField(at: 0) == field)
            ) {
            return 8
        }
        return -1
    }
    
    private func findMove(movesCount: Int, model: TicTacToeModel) -> Int {
        
        
        for i in 0...8 {
            if model.getField(at: i) == FieldEnum.empty {
                return i
            }
        }
        return -1
    }

}

