//
//  TicTacToeModel.swift
//  TicTacToe
//
//  Created by Karol Majka on 04/05/2017.
//  Copyright © 2017 karolmajka. All rights reserved.
//

import Foundation


enum FieldEnum {
    case empty
    case circle
    case cross
    case unknown
    init(n: Int) {
        switch n {
        case 0:
            self = .empty
        case 1:
            self = .circle
        case 2:
            self = .cross
        default:
            self = .unknown
        }
    }
}

enum PlayerEnum {
    case circlePlayer
    case crossPlayer
    case unknown
    init(n: Int) {
        switch n {
        case 0:
            self = .circlePlayer
        case 1:
            self = .crossPlayer
        default:
            self = .unknown
        }
    }
}

class TicTacToeModel {
    var fields: [FieldEnum] = []
    var currentMove: PlayerEnum = PlayerEnum.unknown
    
    init() {
        for _ in 0...8 {
            fields.append(FieldEnum.empty)
        }
        if Int(arc4random()) % 2 == 1 {
            self.currentMove = PlayerEnum.crossPlayer
        } else {
            self.currentMove = PlayerEnum.circlePlayer
        }
    }
    
    
    func getPosition(x: Int, y: Int) -> Int {
        return y*3+x
    }
    
    func getFieldAt(x: Int, y: Int) -> FieldEnum {
        return fields[getPosition(x: x, y: y)]
    }
    
    func getField(at i: Int) -> FieldEnum {
        return fields[i]
    }
    
    func setFieldAt(x: Int, y: Int, as fieldEnum: FieldEnum) {
        setField(at: getPosition(x: x, y: y), as: fieldEnum)
    }
    
    func setField(at i: Int, as fieldEnum: FieldEnum) {
        self.fields[i] = fieldEnum
    }
    
    func checkFields(position1: Int, position2: Int, position3: Int) -> PlayerEnum? {
       if getField(at: position1) == getField(at: position2) && getField(at: position1) == getField(at: position3) {
            let field = getField(at: position1)
            if field == FieldEnum.circle {
                return PlayerEnum.circlePlayer
            } else if field == FieldEnum.cross {
                return PlayerEnum.crossPlayer
            }
        }
        return nil
    }
    
    func checkFields(x1: Int, y1: Int, x2: Int, y2: Int, x3: Int, y3: Int) -> PlayerEnum? {
        return checkFields(position1: getPosition(x: x1, y: y1), position2: getPosition(x: x2, y: y2), position3: getPosition(x: x3, y: y3))
    }
    
    func getAllWinningCombinations() -> [[Int]] {
        var combinations: [[Int]] = []
        
        combinations.append([])
        combinations[0].append(getPosition(x: 0, y: 0))
        combinations[0].append(getPosition(x: 1, y: 0))
        combinations[0].append(getPosition(x: 2, y: 0))
        
        combinations.append([])
        combinations[1].append(getPosition(x: 0, y: 1))
        combinations[1].append(getPosition(x: 1, y: 1))
        combinations[1].append(getPosition(x: 2, y: 1))
        
        combinations.append([])
        combinations[2].append(getPosition(x: 0, y: 2))
        combinations[2].append(getPosition(x: 1, y: 2))
        combinations[2].append(getPosition(x: 2, y: 2))
        
        combinations.append([])
        combinations[3].append(getPosition(x: 0, y: 0))
        combinations[3].append(getPosition(x: 0, y: 1))
        combinations[3].append(getPosition(x: 0, y: 2))
        
        combinations.append([])
        combinations[4].append(getPosition(x: 1, y: 0))
        combinations[4].append(getPosition(x: 1, y: 1))
        combinations[4].append(getPosition(x: 1, y: 2))
        
        combinations.append([])
        combinations[5].append(getPosition(x: 2, y: 0))
        combinations[5].append(getPosition(x: 2, y: 1))
        combinations[5].append(getPosition(x: 2, y: 2))
        
        combinations.append([])
        combinations[6].append(getPosition(x: 0, y: 0))
        combinations[6].append(getPosition(x: 1, y: 1))
        combinations[6].append(getPosition(x: 2, y: 2))
        
        combinations.append([])
        combinations[7].append(getPosition(x: 2, y: 0))
        combinations[7].append(getPosition(x: 1, y: 1))
        combinations[7].append(getPosition(x: 0, y: 2))
        
        return combinations
    }
    
    func checkWinner() -> (PlayerEnum?, [Int]?) {
        for combination in getAllWinningCombinations() {
            if let winner = checkFields(position1: combination[0], position2: combination[1], position3: combination[2]) {
                return (winner, combination)
            }
        }
        return (nil, nil)
    }
    
    func isMoveAvailable() -> Bool {
        for field in self.fields {
            if field == FieldEnum.empty {
                return true
            }
        }
        return false
    }
    
    func toggleCurrentMove() {
        if self.currentMove == PlayerEnum.circlePlayer {
            self.currentMove = PlayerEnum.crossPlayer
        } else {
            self.currentMove = PlayerEnum.circlePlayer
        }
    }
    
}
