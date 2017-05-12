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
        var move: Int
        if movesCount == 0 {
            move = self.getRandomValue(from: [0,1,2,3,4,5,6,7,8], model: model)
            return move
        }
        
        if movesCount == 1 {
            if model.getField(at: 0) != FieldEnum.empty ||
                model.getField(at: 2) != FieldEnum.empty ||
                model.getField(at: 4) != FieldEnum.empty ||
                model.getField(at: 6) != FieldEnum.empty ||
                model.getField(at: 8) != FieldEnum.empty {
                move = self.getRandomValue(from: [0,2,4,6,8], model: model)
                return move
            } else {
                move = self.getRandomValue(from: [0,1,2,3,4,5,6,7,8], model: model)
                return move
            }
        }
        
        var myField: FieldEnum
        var opponentField: FieldEnum
        if self.botSide == PlayerEnum.circlePlayer {
            myField = FieldEnum.circle
            opponentField = FieldEnum.cross
        } else {
            myField = FieldEnum.cross
            opponentField = FieldEnum.circle
        }

        if movesCount == 2 {
            if model.getField(at: 4) == myField && model.getField(at: 0) == opponentField {
                move = 8
                return move
            }
            if model.getField(at: 4) == myField && model.getField(at: 2) == opponentField {
                move = 6
                return move
            }
            if model.getField(at: 4) == myField && model.getField(at: 6) == opponentField {
                move = 2
                return move
            }
            if model.getField(at: 4) == myField && model.getField(at: 8) == opponentField {
                move = 0
                return move
            }

            if model.getField(at: 6) != FieldEnum.empty && model.getField(at: 2) != FieldEnum.empty {
                move = self.getRandomValue(from: [0,8], model: model)
                return move
            }
            if model.getField(at: 0) != FieldEnum.empty && model.getField(at: 8) != FieldEnum.empty {
                move = self.getRandomValue(from: [2,6], model: model)
                return move
            }
            
            if model.getField(at: 0) == myField && (model.getField(at: 2) == opponentField || model.getField(at: 6) == opponentField) {
                move = 8
                return move
            }
            if model.getField(at: 8) == myField && (model.getField(at: 2) == opponentField || model.getField(at: 6) == opponentField) {
                move = 0
                return move
            }
            if model.getField(at: 2) == myField && (model.getField(at: 0) == opponentField || model.getField(at: 8) == opponentField) {
                move = 6
                return move
            }
            if model.getField(at: 6) == myField && (model.getField(at: 0) == opponentField || model.getField(at: 8) == opponentField) {
                move = 2
                return move
            }
        
            if model.getField(at: 4) == myField && (model.getField(at: 0) == opponentField ||
                                                    model.getField(at: 2) == opponentField ||
                                                    model.getField(at: 6) == opponentField ||
                                                    model.getField(at: 8) == opponentField) {
                move = self.getRandomValue(from: [0,1,2,3,4,5,6,7,8], model: model)
                return move
            }

            if (model.getField(at: 0) == myField || model.getField(at: 2) == myField || model.getField(at: 6) == myField || model.getField(at: 8) == myField) &&
                (model.getField(at: 1) == opponentField || model.getField(at: 3) == opponentField || model.getField(at: 5) == opponentField || model.getField(at: 7) == opponentField) {
                move = 4
                return move
            }
            
            if (model.getField(at: 1) == myField || model.getField(at: 7) == myField) && model.getField(at: 4) == opponentField {
                move = self.getRandomValue(from: [3,5], model: model)
                return move
            }
            if (model.getField(at: 3) == myField || model.getField(at: 5) == myField) && model.getField(at: 4) == opponentField {
                move = self.getRandomValue(from: [3,5], model: model)
                return move
            }

            
            if (model.getField(at: 1) == myField || model.getField(at: 3) == myField || model.getField(at: 5) == myField || model.getField(at: 7) == myField) &&
                model.getField(at: 4) == FieldEnum.empty {
                move = 4
                return move
            }
        }
        
        if movesCount == 3 {
            
            if model.getField(at: 4) == myField &&
                ((model.getField(at: 2) == model.getField(at: 6) && model.getField(at: 2) == opponentField) ||
                    (model.getField(at: 0) == model.getField(at: 8) && model.getField(at: 0) == opponentField)) {
                move = self.getRandomValue(from: [1,3,5,7], model: model)
                return move
            }
            
            if model.getField(at: 4) == opponentField && (
                (model.getField(at: 1) == opponentField && model.getField(at: 7) == myField) ||
                (model.getField(at: 7) == opponentField && model.getField(at: 1) == myField) ||
                (model.getField(at: 3) == opponentField && model.getField(at: 5) == myField) ||
                    (model.getField(at: 5) == opponentField && model.getField(at: 3) == myField)) {
                move = self.getRandomValue(from: [0,1,2,3,4,5,6,7,8], model: model)
                return move
            }
            
            if model.getField(at: 1) == opponentField && model.getField(at: 7) == myField && (model.getField(at: 6) == opponentField || model.getField(at: 8) == opponentField) {
                move = self.getRandomValue(from: [0,2], model: model)
                return move
            }
            if model.getField(at: 1) == opponentField && model.getField(at: 7) == myField && (model.getField(at: 0) == opponentField || model.getField(at: 2) == opponentField) {
                move = self.getRandomValue(from: [6,8], model: model)
                return move
            }
            if model.getField(at: 3) == opponentField && model.getField(at: 5) == myField && (model.getField(at: 0) == opponentField || model.getField(at: 6) == opponentField) {
                move = self.getRandomValue(from: [2,8], model: model)
                return move
            }
            if model.getField(at: 3) == opponentField && model.getField(at: 5) == myField && (model.getField(at: 2) == opponentField || model.getField(at: 8) == opponentField) {
                move = self.getRandomValue(from: [0,6], model: model)
                return move
            }

            if model.getField(at: 1) == opponentField && (
                (model.getField(at: 6) == opponentField && model.getField(at: 2) == myField) ||
                (model.getField(at: 2) == opponentField && model.getField(at: 6) == myField) ||
                (model.getField(at: 0) == opponentField && model.getField(at: 8) == myField) ||
                    (model.getField(at: 8) == opponentField && model.getField(at: 0) == myField)) {
                move = self.getRandomValue(from: [0,2,6,8], model: model)
                return move
            }

            if model.getField(at: 1) == opponentField &&
                (model.getField(at: 3) == myField || model.getField(at: 5) == myField) &&
                (model.getField(at: 6) == opponentField || model.getField(at: 8) == opponentField) ||
                model.getField(at: 3) == opponentField &&
                    (model.getField(at: 1) == myField || model.getField(at: 7) == myField) &&
                    (model.getField(at: 2) == opponentField || model.getField(at: 8) == opponentField) ||
                model.getField(at: 5) == opponentField &&
                    (model.getField(at: 1) == myField || model.getField(at: 7) == myField) &&
                    (model.getField(at: 0) == opponentField || model.getField(at: 6) == opponentField) ||
                model.getField(at: 7) == opponentField &&
                    (model.getField(at: 3) == myField || model.getField(at: 5) == myField) &&
                    (model.getField(at: 0) == opponentField || model.getField(at: 2) == opponentField) {
                move = 4
                return move
            }
            
            if model.getField(at: 4) == myField {
                if model.getField(at: 1) == opponentField && model.getField(at: 3) == opponentField {
                    move = 0
                    return move
                }
                if model.getField(at: 1) == opponentField && model.getField(at: 5) == opponentField {
                    move = 2
                    return move
                }
                if model.getField(at: 3) == opponentField && model.getField(at: 7) == opponentField {
                    move = 6
                    return move
                }
                if model.getField(at: 5) == opponentField && model.getField(at: 7) == opponentField {
                    move = 8
                    return move
                }
            }
        }
        
        if model.getField(at: 4) == FieldEnum.empty {
            move = 4
            return move
        }
        
        for i in 0...8 {
            if model.getField(at: i) == FieldEnum.empty {
                return i
            }
        }
        return -1
    }
    
    private func getRandomValue(from values: [Int], model: TicTacToeModel) -> Int {
        var move = Int(arc4random_uniform(9))
        while model.getField(at: move) != FieldEnum.empty || !values.contains(move) {
            move = Int(arc4random_uniform(9))
        }
        return move
    }
}
