//
//  MainViewModel.swift
//  CoffeeRewards
//
//  Created by Kraig Spear on 8/30/16.
//  Copyright © 2016 Meijer. All rights reserved.
//

import Foundation
import CoffeeService
import QRLib

enum MainViewModelProperty {
    case qrCode(image: UIImage)
    case name(name: String)
    case welcomeText(welcomeText: String)
    case dispensed(dispensed: String)
    case untilNextReward(untilNextReward: String)
}

protocol MainViewModelDelegate: class {
    func onPropertyChanged(property: MainViewModelProperty)
    func qrImageSize() -> CGSize
}

final class MainViewModel {
    
    //MARK: - Members
    private let codeGenerator: QRCodeGeneratorable
    private let coffeeService: CoffeeServiceable
    private weak var delegate: MainViewModelDelegate?
    
    var qrImage: UIImage? {
        didSet {
            guard let qrImage = qrImage else {return}
            delegate?.onPropertyChanged(property: .qrCode(image: qrImage))
        }
    }
    
    var dispensed = "" {
        didSet {
            delegate?.onPropertyChanged(property: .dispensed(dispensed: dispensed))
        }
    }
    
    var untilNextReward = "" {
        didSet {
            delegate?.onPropertyChanged(property: .untilNextReward(untilNextReward: untilNextReward))
        }
    }

    
    public var name = "" {
        didSet {
            delegate?.onPropertyChanged(property: .name(name: name))
        }
    }
    
    public var welcomeText: String = "" {
        didSet {
            delegate?.onPropertyChanged(property: .welcomeText(welcomeText: welcomeText))
        }
    }
    
    //MARK: - Init
    init(codeGenerator: QRCodeGeneratorable,
         coffeeService: CoffeeServiceable,
         delegate: MainViewModelDelegate) {
        self.codeGenerator = codeGenerator
        self.coffeeService = coffeeService
        self.delegate = delegate
    }
    
    convenience init(delegate: MainViewModelDelegate) {
        self.init(codeGenerator: QRCodeGenerator(),
                  coffeeService: CoffeeService(),
                  delegate: delegate
        )
    }
    
    func reload() {
        guard let delegate = delegate else {return}
        welcomeText = "Welcome, \(name)"
        qrImage = codeGenerator.generate(from: name, at: delegate.qrImageSize())
    }
    
    func coffeeDispensed(completed: @escaping () -> Void ) {
        coffeeService.dispense {[weak self]
            (dispenseCount) in
            guard let this = self else {return}
            this.dispensed = "Dispensed \(dispenseCount)"
            this.untilNextReward = "Until next reward \(this.coffeeService.numberUntilReward)"
            completed()
        }
    }
    
    
    func generateQrImage(withSize: CGSize) -> UIImage {
        return codeGenerator.generate(from: name, at: withSize)
    }
}
