//
//  TicTacToeBot.swift
//  TicTacToe
//
//  Created by Karol Majka on 11/05/2017.
//  Copyright © 2017 karolmajka. All rights reserved.
//

import Foundation


class TicTacToeBot {
    func move(field: TicTacToeModel) -> Int {
        for i in 0...8 {
            if field.getField(at: i) == FieldEnum.empty {
                if !field.setField(at: i) {
                    return -1
                }
                return i
            }
        }
        return -1
    }
}
