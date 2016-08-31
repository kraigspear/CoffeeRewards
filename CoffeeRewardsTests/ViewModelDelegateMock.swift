//
//  ViewModelDelegateMock.swift
//  CoffeeRewards
//
//  Created by Kraig Spear on 8/31/16.
//  Copyright © 2016 Meijer. All rights reserved.
//

import UIKit
@testable import CoffeeRewards

final class ViewModelDelegateMock: MainViewModelDelegate {
    
    var _qrCode: UIImage?
    var _welcomeText: String?
    var _dispensedText: String?
    var _untilNextText: String?
    var _name: String?
    
    func onPropertyChanged(property: MainViewModelProperty) {
        switch property {
        case .qrCode(image: let image):
            _qrCode = image
        case .welcomeText(welcomeText: let welcomeText):
            _welcomeText = welcomeText
        case .dispensed(dispensed: let dispensedText):
            _dispensedText = dispensedText
        case .untilNextReward(untilNextReward: let nextReward):
            _untilNextText = nextReward
        case .name(name: let name):
            _name = name
        }
    }
    
    func qrImageSize() -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
