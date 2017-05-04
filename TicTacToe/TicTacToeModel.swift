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

class TicTacToeModel: NSObject {
    var field: [FieldEnum] = []
    
    override init() {
        super.init()
        for _ in 0...8 {
            field.append(FieldEnum.empty)
        }
    }
    func getFieldAt(x: Int, y: Int) -> FieldEnum {
        return field[y*3+x]
    }
    //func
}
