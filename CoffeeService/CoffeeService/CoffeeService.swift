//
//  CoffeeService.swift
//  CoffeeService
//
//  Created by Kraig Spear on 8/30/16.
//  Copyright © 2016 Meijer. All rights reserved.
//

import Foundation

public protocol CoffeeServiceable {
    func dispense(whenCompleted: (Int) -> Void)
    var numberUntilReward: Int {get}
}

public final class CoffeeService: CoffeeServiceable {
    private (set) public var dispenseCount = 0
    private let maxDispense = 6
    
    public init() {}
    
    public func dispense(whenCompleted: (Int) -> Void) {
        if dispenseCount + 1 < maxDispense {
            dispenseCount += 1
        }
        else {
            dispenseCount = 0
        }
        whenCompleted(dispenseCount)
    }
    
    public var numberUntilReward: Int {
        return maxDispense - dispenseCount
    }
}
