//
//  User.swift
//  VendingMachine
//
//  Created by yangpc on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct User: Person {
    var delegate: UserMode
    enum Option: Int {
        case addMoney = 1
        case buyDrink = 2
    }
    init(userMode: UserMode) {
        delegate = userMode
    }
    
    mutating func action(option: Int, detail: Int) throws -> Drink? {
        switch option {
        case Option.addMoney.rawValue:
            delegate.add(money: detail)
            return nil
        case Option.buyDrink.rawValue:
            let drink = try delegate.buy(productIndex: detail)
            return drink
        default: break
        }
        throw OptionError.invalidAction
    }
}

extension User {
    enum OptionError: String, Error {
        case invalidAction = "유효하지 않은 명령입니다."
    }
}
