//
//  CoffeeRewardsTests.swift
//  CoffeeRewardsTests
//
//  Created by admin on 8/30/16.
//  Copyright © 2016 Meijer. All rights reserved.
//

import XCTest
@testable import CoffeeRewards
@testable import CoffeeService
@testable import QRLib


final class MainViewModelTest: XCTestCase {
    
    var mainViewModel: MainViewModel!
    var viewModelDelegate: ViewModelDelegateMock!
    var qrImageMock: QRCodeGeneratorableMock!
    var serviceMock: ServiceMock!
    
    override func setUp() {
        super.setUp()
        viewModelDelegate = ViewModelDelegateMock()
        qrImageMock = QRCodeGeneratorableMock()
        serviceMock = ServiceMock()
        mainViewModel = MainViewModel(codeGenerator: qrImageMock,
                                      coffeeService: serviceMock, delegate: viewModelDelegate)
    }
    
    
    func testWelcomeMessage() {
        mainViewModel.name = "Mr Tester"
        mainViewModel.reload()
        let expectedWelcome = "Welcome, Mr Tester"
        XCTAssertEqual(expectedWelcome, viewModelDelegate._welcomeText)
    }
    
    func testQRCodeSet() {
        XCTAssertNil(viewModelDelegate._qrCode)
        mainViewModel.reload()
        XCTAssertNotNil(viewModelDelegate._qrCode)
    }
    
    func testDispenseTextUpdated() {
        
        serviceMock._whenCompleted = 5
        mainViewModel.reload()
        
        let readyExpectation = expectation(description: "ready")
        
        mainViewModel.coffeeDispensed {
            let expected = "Dispensed 5"
          XCTAssertEqual(expected, self.mainViewModel.dispensed)
          XCTAssertEqual(expected, self.viewModelDelegate._dispensedText)
          readyExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error, "Error")
        }
    }
    
    func testUntilNextRewardTextUpdated() {
        
        serviceMock._numberUntilReward = 4
        mainViewModel.reload()
        
        let readyExpectation = expectation(description: "ready")
        
        mainViewModel.coffeeDispensed {
            let expected = "Until next reward 4"
            XCTAssertEqual(expected, self.mainViewModel.untilNextReward)
            XCTAssertEqual(expected, self.viewModelDelegate._untilNextText)
            readyExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error, "Error")
        }
    }

    
}
