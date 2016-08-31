//
//  QRCodeGeneratorableMock.swift
//  CoffeeRewards
//
//  Created by Kraig Spear on 8/31/16.
//  Copyright © 2016 Meijer. All rights reserved.
//

import UIKit
@testable import QRLib

final class QRCodeGeneratorableMock: QRCodeGeneratorable {
    var _image: UIImage!
    var _from: String!
    var _size: CGSize!
    
    init() {
        _image = UIImage(named: "QRCode.png")
        print(_image)
    }
    
    func generate(from: String, at: CGSize) -> UIImage {
        _from = from
        _size = at
        return _image
    }
}
