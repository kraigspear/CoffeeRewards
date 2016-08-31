//
//  ServiceMock.swift
//  CoffeeRewards
//
//  Created by admin on 8/31/16.
//  Copyright © 2016 Meijer. All rights reserved.
//

import Foundation
@testable import CoffeeService

final class ServiceMock: CoffeeServiceable {
    
    var _whenCompleted = 0
    
    func dispense(whenCompleted: (Int) -> Void) {
        whenCompleted(_whenCompleted)
    }
    
    var _numberUntilReward = 0
    var numberUntilReward: Int {
        get {
            return _numberUntilReward
        }
        set {
            _numberUntilReward = newValue
        }
    }
}
