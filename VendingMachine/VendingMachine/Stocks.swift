//
//  Stocks.swift
//  VendingMachine
//
//  Created by 이동건 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class Stocks {
    private var bundles: [[Beverage]]
    var availables: [Beverage:Int] {
        let beverages = bundles.compactMap { $0.first }
        let count = bundles.compactMap {$0.count}
        return Dictionary(uniqueKeysWithValues: zip(beverages, count))
    }
    init(_ list: [Beverage]) {
        // 종류 별로 묶음
        self.bundles = Dictionary(grouping: list, by: { $0.className }).values.map { $0 }
    }
    
    func append(_ beverage: Beverage) {
        let result = bundles.filter { $0.first?.className == beverage.className }
        var bundle = result.first
        bundle?.append(beverage)
    }
    
    func hasBundle(_ value: Int) -> Bool {
        return value <= bundles.count
    }
    
    // 잔액이 0 이면 가격을 제외한 목록만, 0 이상이라면 가격과 함께 선택 가능한 리스트 형태로 출력
    func getInfo(hasAccount: Bool, handler: ([Beverage])->(String)) -> String {
        var result = hasAccount ? "" : "\n=>"
        bundles.enumerated().forEach {
            var prefix = hasAccount ? "\n\($0.offset + 1))" : ""
            prefix += handler($0.element)
            result += prefix
        }
        return result
    }
    
    func availables(with money: Int) -> [Beverage] {
        return bundles.compactMap { $0.first }.filter { $0.isPurchasable(with: money) }
    }
}
